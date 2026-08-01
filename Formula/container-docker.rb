class ContainerDocker < Formula
  desc "Docker CLI compatibility shim for Apple's container runtime"
  homepage "https://github.com/k2patel/container-docker"
  url "https://github.com/k2patel/container-docker/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "52c7bbc04b1843d80464e3a33bcc0720846971db7bb3d1344aa6acc745f85c02"
  license "MIT"

  depends_on "container"

  conflicts_with "docker", because: "both install a docker executable"

  def install
    bin.install "bin/docker"
  end

  def caveats
    <<~EOS
      Initialize Apple's container runtime before using the Docker shim:
        container system start
    EOS
  end

  test do
    ENV["CONTAINER_DOCKER_DRY_RUN"] = "1"
    assert_equal "container image list\n", shell_output("#{bin}/docker images")
  end
end
