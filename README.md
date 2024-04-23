<div align="center">

<!-- PROJECT LOGO -->
# 📝 Keycloak Docker Compose

![Keycloak Badge](https://img.shields.io/badge/Keycloak-4D4D4D?logo=keycloak&logoColor=fff&style=flat)
![Docker Badge](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=flat)
![PostgreSQL Badge](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=fff&style=flat)

---

This project serves the purpose of setting up a `Keycloak` instance leveraging `docker compose` exposed over HTTPS leveraging self-signed certificates.

---

[Report Bug](https://github.com/paf-triarii/Keycloak-Docker-Compose/issues) · [Request Feature](https://github.com/paf-triarii/Keycloak-Docker-Compose/issues)
</div>

<!-- TABLE OF CONTENTS -->


## 📚 Table of contents

- [📝 Keycloak Docker Compose](#-keycloak-docker-compose)
  - [📚 Table of contents](#-table-of-contents)
  - [💡 Structure](#-structure)
  - [🚀 Installation and Execution](#-installation-and-execution)
    - [🔨 Prerequisites](#-prerequisites)
    - [🗜️ Installation](#️-installation)
      - [Local environment](#local-environment)
      - [Docker environment](#docker-environment)
    - [💼 Usage](#-usage)
  - [📍 Roadmap](#-roadmap)
  - [📎 Contributing](#-contributing)
  - [📃 License](#-license)
  - [👥 Contact](#-contact)
  - [🔍 Acknowledgments](#-acknowledgments)

<!--te-->

<!-- PROJECT DETAILS -->
## 💡 Structure


## 🚀 Installation and Execution

### 🔨 Prerequisites

- Docker CE installed (including compose plugin) - [How to install Docker CE](https://docs.docker.com/engine/install/)
- yq YAML processor installed.

```bash
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod a+x /usr/local/bin/yq
```


[🔝 Back to top](#-keycloak-docker-compose)

### 🗜️ Installation

#### Local environment

1. Clone the repo

   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```

2. Install packages

   ```sh
   npm install
   ```

3. Enter your API in `config.js`

   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

#### Docker environment

Install `Docker Engine`. Visit [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/) for more information.

1. Build docker image:

```bash
docker build -t <image_name>:<tag> .
```

2. Run docker image:

```bash
docker run -it --name <container_name> -p <ports...> -v <volumes...> <image_name>:<tag>
```

[🔝 Back to top](#-keycloak-docker-compose)

<!-- USAGE EXAMPLES -->
### 💼 Usage


_For more examples, please refer to the [Documentation](https://example.com)_

[🔝 Back to top](#-keycloak-docker-compose)

<!-- GETTING STARTED -->

<!-- ROADMAP -->
## 📍 Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
  - [x] English
  - [ ] Spanish

See the [open issues](https://github.com/paf-triarii/Keycloak-Docker-Compose/issues) for a full list of proposed features (and known issues).

[🔝 Back to top](#-keycloak-docker-compose)

<!-- CONTRIBUTING -->
## 📎 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated** :chart:.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch

   ```sh
   git checkout -b feature/AmazingFeature
   ```

3. Commit your Changes

   ```sh
   git commit -m 'Add some AmazingFeature
   ```

4. Push to the Branch

   ```sh
   git push origin feature/AmazingFeature
   ```

5. Open a Pull Request

[🔝 Back to top](#-keycloak-docker-compose)

<!-- LICENSE -->
## 📃 License

Distributed under the [`APACHE 2.0`](./LICENSE) License.

[🔝 Back to top](#-keycloak-docker-compose)

<!-- CONTACT -->
## 👥 Contact

<div align="center">

---

**`PAF TRIARII (pedroarias1015@gmail.com) a member of Code Triarii`**

---

[![X](https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white)](https://twitter.com/codetriariism)
[![TikTok](https://img.shields.io/badge/TikTok-%23000000.svg?style=for-the-badge&logo=TikTok&logoColor=white)](https://www.tiktok.com/@codetriariism)
[![Medium](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@codetriariism)
[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://www.youtube.com/@CodeTriariiSM)
[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=Instagram&logoColor=white)](https://www.instagram.com/codetriariismig/)

</div>

As we always state, our main purpose is keep learning, contributing to the community and finding ways to collaborate in interesting initiatives.
Do not hesitate to contact us at `codetriariism@gmail.com`

If you are interested in our content creation, also check our social media accounts. We have all sorts of training resources, blogs, hackathons, write-ups and more!
Do not skip it, you will like it :smirk: :smirk: :smirk: :+1:

Don't forget to give the project a star if you liked it! Thanks again! :star2: :yellow_heart:

[🔝 Back to top](#-keycloak-docker-compose)

<!-- ACKNOWLEDGMENTS -->
## 🔍 Acknowledgments

:100: :100: :100: For those that are curious about some of the resources or utilities and for sure thanking and giving credit to authors, we provide you a list of the most interesting ones (in our understanding) :100: :100: :100:

- [eabykov Keycloak Compose](https://github.com/eabykov/keycloak-compose/tree/main) - Thank you for the reference. The star is given 😉
- [Keycloak in a container - Official Documentation](https://www.keycloak.org/server/containers)

[🔝 Back to top](#-keycloak-docker-compose)