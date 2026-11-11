# typed: strict
# frozen_string_literal: true

# Installs the standalone Petika CLI for the host platform.
class Petika < Formula
  desc "Password manager with encrypted local vaults"
  homepage "https://github.com/k2patel/petika"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.0/petika-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "f05d41f7f6f47a7e5d944800092901d57e1cca6461f3fe01eba7959ca828b79a"
    end
    on_intel do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.0/petika-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "5b8e862837735683389bf64e78e266a1afdeebf687107e49d64f28bf851ac98d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.0/petika-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "62abc2eeef2cc071feaf5c65b7579056197c1ec1fbb65d8a7cd80d91f5df28d7"
    end
    on_intel do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.0/petika-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36835e9c4696e1b978ec61348777a90791851f0f214ccc49b5a67a0cb43e1d91"
    end
  end

  def install
    bin.install "petika"
    pkgshare.install "LICENSE", "THIRD_PARTY_NOTICES.txt", "build.json"
  end

  def caveats
    <<~EOS
      The CLI supports browser-approved account login and legacy passphrase or
      recipient vaults. Access to secrets in browser-passkey vaults requires
      per-action device approval integration, which is pending.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/petika --version")
    store = testpath/"test.petika"
    command = [bin/"petika", "--no-config", "--store", store, "--passphrase-stdin"]
    passphrase = "synthetic Homebrew test passphrase\n"
    secret = "synthetic Homebrew test secret"

    pipe_output([*command, "init"].shelljoin, passphrase * 2, 0)
    pipe_output([*command, "put", "brew-test", "--password-stdin"].shelljoin, "#{passphrase}#{secret}\n", 0)
    refute_includes store.binread, secret
    assert_equal "#{secret}\n", pipe_output([*command, "get", "brew-test", "--reveal"].shelljoin, passphrase, 0)
  end
end
