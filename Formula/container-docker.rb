class ContainerDocker < Formula
  desc "Docker CLI compatibility shim for Apple's container runtime"
  homepage "https://github.com/k2patel/container-docker"
  url "https://github.com/k2patel/container-docker/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b1a3f209336af56787b91060f7f03d88476c42a4bc4a7bd5a789a2f2b7f3c41b"
  license "MIT"

  depends_on "container"

  conflicts_with "docker", because: "both install a docker executable"
  conflicts_with "docker-completion", because: "both install zsh completion for docker"

  def install
    bin.install "bin/docker"
    zsh_completion.install "completions/_docker"
  end

  def caveats
    <<~EOS
      This formula provides a command named `docker`. It conflicts with any
      other active Docker-compatible wrapper, including Docker Desktop
      (`docker-desktop`), `podman-docker`, Rancher Desktop, and OrbStack.
      Plain `podman` and Podman Desktop can coexist unless configured to add a
      `docker` alias, symlink, or wrapper.

      Homebrew enforces the conflict with its `docker` formula. For casks and
      unmanaged wrappers, check command resolution and adjust PATH as needed:
        whence -a docker

      Initialize Apple's container runtime before using the Docker shim:
        container system start
    EOS
  end

  test do
    ENV["CONTAINER_DOCKER_DRY_RUN"] = "1"
    assert_equal "container image list\n", shell_output("#{bin}/docker images")
  end
end
