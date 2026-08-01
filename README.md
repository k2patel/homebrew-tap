# Homebrew tap

Homebrew formulae maintained by K2 Patel.

## container-docker

[`container-docker`](https://github.com/k2patel/container-docker) translates
familiar Docker CLI commands to Apple's native `container` runtime.

Install the shim and its Apple `container` dependency:

```zsh
brew install k2patel/tap/container-docker
container system start
```

Verify the installation without contacting the runtime:

```zsh
CONTAINER_DOCKER_DRY_RUN=1 docker images
```

The expected output is `container image list`.

The formula installs an executable named `docker`, so it conflicts with the
Homebrew Docker CLI formula and may conflict with Docker Desktop's CLI link.
