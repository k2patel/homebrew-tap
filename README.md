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

The formula installs zsh completion automatically. Open a new terminal, type
`docker`, and press <kbd>Tab</kbd> to complete supported commands and common
options.

## Command conflicts

The formula installs an executable named `docker`. Homebrew enforces its
conflict with the `docker` formula. Homebrew formulas cannot declare conflicts
against casks or unmanaged wrappers, so also check for these competing
providers:

- Docker Desktop (`docker-desktop` cask)
- `podman-docker` compatibility wrappers
- Rancher Desktop configured to provide `docker`
- OrbStack
- any manually installed `docker` alias, symlink, or wrapper

Plain `podman` and Podman Desktop can coexist unless configured to add a command
named `docker`. Check which implementation will run with:

```zsh
whence -a docker
```
