#!/bin/bash

#################################
#           Functions           #
#################################

display_help() {
  echo -e "\033[34mUsage: $0 [OPTIONS]\033[0m"
  echo
  echo -e "\033[34mOptions:\033[0m"
  echo -e "\033[34m  --db_user       PostgreSQL database user. Default: keycloak\033[0m"
  echo -e "\033[34m  --db_password   PostgreSQL database password. Default: keycloak\033[0m"
  echo -e "\033[34m  --db_name       PostgreSQL database name. Default: keycloak\033[0m"
  echo -e "\033[34m  --gen_certs     Indicates if self-signed certificates should be generated\033[0m"
  echo -e "\033[34m  --key           Path to the private key file (required if --gen_certs is not set)\033[0m"
  echo -e "\033[34m  --cert          Path to the certificate file (required if --gen_certs is not set)\033[0m"
  echo -e "\033[34m  --domain       Common Name (CN) for the generated self-signed certificates. Default: Ip of eth0 interface of your system.\033[0m"
  echo -e "\033[34m  --cert-org      Organization (O) for the generated self-signed certificates. Default: CodeTriarii\033[0m"
  echo -e "\033[34m  --user          User for the Keycloak instance admin. Default: admin\033[0m"
  echo -e "\033[34m  --password      Password for the Keycloak instance admin. Default: admin\033[0m"
  echo -e "\033[34m  --port          Port for the Keycloak instance. Default: 8443\033[0m"
  echo -e "\033[34m  --clean         If set, removes the docker compose and auxiliar generated assets.\033[0m"
  echo
  exit 0
}

create_env() {
  # Check if .env file exists and remove it
  if [ -f .env ]; then
    rm .env
  fi

  echo "POSTGRES_USER=${db_user}" >> .env
  echo "POSTGRES_PASSWORD=${db_password}" >> .env
  echo "POSTGRES_DB=${db_name}" >> .env
  echo "KEYCLOAK_ADMIN=${user}" >> .env
  echo "KEYCLOAK_ADMIN_PASSWORD=${password}" >> .env
  echo "KC_DB=postgres" >> .env
  echo "KC_DB_USERNAME=${db_user}" >> .env
  echo "KC_DB_PASSWORD=${db_password}" >> .env
  echo "KC_DB_URL=jdbc:postgresql://postgres:5432/${db_name}" >> .env
  echo "KC_HOSTNAME=${domain}" >> .env
}

copy_docker_compose() {
  if [ -f docker-compose-ready.yml ]; then
    rm docker-compose-ready.yml
  fi
  cp docker-compose.yml docker-compose-ready.yml
}

set_docker_images() {
  yq read docker-compose.yml -j | jq ".services.postgres.image = \"postgres:${postgres_version}\"" |  jq ".services.keycloak.image = \"quay.io/keycloak/keycloak:${keycloak_version}\"" | yq read -P - > docker-compose-ready.yml
}

set_ports() {
  cp docker-compose-ready.yml docker-compose-ready.yml.bak
  yq read docker-compose-ready.yml.bak -j | jq ".services.keycloak.ports = [\"${port}:8443\"]" | yq read -P - > docker-compose-ready.yml
  rm docker-compose-ready.yml.bak
}

create_keycloak_certs() {
  if [ "$gen_certs" = true ]; then
    docker run -d --rm --name keycloak-gen -w /opt/keycloak --entrypoint sleep quay.io/keycloak/keycloak:${keycloak_version} infinity
    docker exec -it keycloak-gen sh -c  "keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname \"CN=${domain}\" -alias server -ext \"SAN:c=DNS:localhost,IP:127.0.0.1\" -keystore conf/server.keystore"
    docker exec -it keycloak-gen sh -c  "keytool -exportcert -alias server -storepass password -file conf/server.crt -keystore conf/server.keystore"
    docker cp keycloak-gen:/opt/keycloak/conf/server.keystore server.keystore
    docker cp keycloak-gen:/opt/keycloak/conf/server.crt server.crt
    docker rm -f keycloak-gen
    openssl x509 -inform der -in server.crt -out server.pem
  fi
}

use_provided_certs() {
  if [ "$gen_certs" = false ]; then
    docker run -d --rm --name keycloak-gen -w /opt/keycloak --entrypoint sleep quay.io/keycloak/keycloak:${keycloak_version} infinity
    docker cp $cert keycloak-gen:/opt/keycloak/conf/cert.pem
    docker cp $key keycloak-gen:/opt/keycloak/conf/key.pem
    docker exec -it keycloak-gen sh -c "openssl pkcs12 -export -in conf/cert.pem -inkey conf/key.pem -out conf/server.keystore -name server -noiter -nomaciter -password pass:password"
    docker cp keycloak-gen:/opt/keycloak/conf/server.keystore server.keystore
    docker rm -f keycloak-gen
  fi
}

print_details() {
  echo -e "\n\n\033[32mUser: $user\033[0m"
  echo -e "\033[32mPassword: $password\033[0m"
  echo -e "Keycloak is accesible here: https://$domain:$port"
  echo -e "\n\033[33mTo view the logs of Keycloak, run the following command:\033[32m docker logs -f keycloak-docker-compose-keycloak-1\033[0m"
}


#################################
#           Arguments           #
#################################

if [ $# -eq 0 ]; then
  display_help
fi

set_defaults() {
  user="${user:-admin}"
  password="${password:-admin}"
  db_user="${db_user:-keycloak}"
  db_password="${db_password:-keycloak}"
  db_name="${db_name:-keycloak}"
  postgres_version="${postgres_version:-16}"
  keycloak_version="${keycloak_version:-24.0.1}"
  domain="${domain:-$(ip addr show eth0 | grep -oP 'inet \K[\d.]+')}"
  cert_org="${cert_org:-CodeTriarii}"
  port="${port:-8443}"
}

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --help)
      display_help
      ;;
    --user)
      user="$2"
      shift
      shift
      ;;
    --password)
      password="$2"
      shift
      shift
      ;;
    --db_user)
      db_user="$2"
      shift
      shift
      ;;
    --db_password)
      db_password="$2"
      shift
      shift
      ;;
    --db_name)
      db_name="$2"
      shift
      shift
      ;;
    --gen_certs)
      gen_certs="true"
      shift
      ;;
    --key)
      key="$2"
      shift
      shift
      ;;
    --cert)
      cert="$2"
      shift
      shift
      ;;
    --domain)
      domain="$2"
      shift
      shift
      ;;
    --cert-org)
      cert_org="$2"
      shift
      shift
      ;;
    --postgres_version)
      postgres_version="$2"
      shift
      shift
      ;;
    --keycloak_version)
      keycloak_version="$2"
      shift
      shift
      ;;
    --port)
      port="$2"
      shift
      shift
      ;;
    --clean)
      clean="true"
      shift
      ;;
    *)
      echo "Unknown option: $key"
      display_help
      exit 1
      ;;
  esac
done

#################################
#        Main Execution         #
#################################

if [ "$clean" = true ]; then
  docker compose -f docker-compose-ready.yml down -v
  rm -f .env
  rm -f docker-compose-ready.yml
  rm -f server.keystore
  rm -f server.pem
else
  set_defaults
  create_env
  copy_docker_compose
  set_docker_images
  set_ports
  create_keycloak_certs
  use_provided_certs
  docker compose -f docker-compose-ready.yml up -d
  print_details
fi

