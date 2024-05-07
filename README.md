# k3d-lab-terraform

> [k3d](https://k3d.io/)/[k3s](https://k3s.io/) lab using [openTofu](https://opentofu.org/) (prev. terraform)

Have a ready for use [Kubernetes](https://kubernetes.io/) cluster in minutes inside Docker!

## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes.

### Prerequisites

- [Node.js >= 20](https://nodejs.org/)

> ℹ️ using a node.js version manager such as [fnm](https://github.com/Schniz/fnm#installation) is warmly recommended

- [Docker](https://www.docker.com/products/docker-desktop/)

> ℹ️ on MacOS, using [OrbStack](https://orbstack.dev/), a drop-in replacement for Docker, is warmly recommended

### Installing

> ℹ️ these steps use `fnm`, please adjust accordingly depending on the version manager you are using

```shell
fnm use --install-if-missing
corepack enable
pnpm install
```
