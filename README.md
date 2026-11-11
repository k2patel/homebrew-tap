# Homebrew tap

Homebrew formulae maintained by K2 Patel.

## Petika

[Petika](https://github.com/k2patel/petika) is a password manager with encrypted
local vaults. The formula installs the standalone CLI on macOS (Apple Silicon
and Intel) and Linux (ARM64 and x86-64). It verifies the archive against a
pinned SHA-256 checksum. Windows x86-64 is available from the
[CLI release](https://github.com/k2patel/petika/releases/tag/cli-v0.1.1).

```sh
brew install k2patel/tap/petika
petika --version
brew test k2patel/tap/petika
```

CLI 0.1.1 includes opt-in Touch ID unlock for local passphrase vaults on supported
Macs. Enrollment verifies the existing vault passphrase and Touch ID approval.

```sh
petika biometric enable
petika --biometric get Email/example --reveal
```

To upgrade an existing installation:

```sh
brew update
brew upgrade k2patel/tap/petika
```

The CLI supports browser-approved account login and legacy passphrase or
recipient vaults. Access to browser-passkey vault secrets from the CLI requires
per-action device approval integration, which is pending.

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
