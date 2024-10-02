# Linux Developer Setup Script

This project provides a bash script to quickly set up a development environment on Debian-based Linux distributions (such as Ubuntu). The script includes options for installing various programming languages, development tools, cloud platforms, and more, making it easier for developers to get started with coding on a fresh installation.

## Features

- Install and configure programming languages: Python, Node.js, Go, Java, C/C++, and more.
- Set up cloud development tools like Docker, Kubernetes, AWS CLI, GCP SDK, and Azure CLI.
- Install essential developer tools: Git, Vim, VS Code, Sublime Text, etc.
- Set up version managers like `pyenv`, `nvm`, and `rbenv` for flexible language versioning.
- Optionally install web development platforms: Django, Flask, React, and Angular.
- Easy customization: Select which tools and languages you want to install.

## Prerequisites

- A fresh install of a Debian-based Linux distribution (Ubuntu, Linux Mint, etc.).
- **sudo** privileges.
- Basic familiarity with running bash scripts.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/linux-dev-setup.git
   cd linux-dev-setup
   ```

2. **Make the script executable:**
   ```bash
   chmod +x setup.sh
   ```

3. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

4. **Follow the prompts** to choose the programming platforms, cloud tools, and other options you want to install.

## Supported Programming Platforms

- **Python**: Includes `pyenv` for version management.
- **Node.js**: With `nvm` for managing Node versions.
- **Go**
- **Java**: Includes JDK installation.
- **C/C++**
- **Ruby**: With `rbenv` for version management.
- **PHP**
- **Rust**

## Cloud & Development Tools

- **Docker**: Containerization tool for application development.
- **Kubernetes**: Container orchestration system.
- **AWS CLI**: Command-line interface for Amazon Web Services.
- **GCP SDK**: Tools for Google Cloud Platform.
- **Azure CLI**: Command-line tools for Microsoft Azure.
- **Git**: Version control system.
- **Visual Studio Code**: Popular source code editor.
- **Sublime Text**: Lightweight text editor.

## Optional Web Development Frameworks

- **Django**: High-level Python web framework.
- **Flask**: Lightweight Python web framework.
- **React**: JavaScript library for building user interfaces.
- **Angular**: Front-end web framework for building dynamic applications.

## Customization

You can easily modify the script to add or remove tools based on your requirements. To do this, open `setup.sh` and comment/uncomment sections corresponding to the tools and platforms you need.

## How to Contribute

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/new-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/new-feature`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

- **Maintainer**: Somen Samanta
- **Email**: thesomen123@gmail.com

Feel free to open an issue if you have any questions or suggestions!

---
