# typed: strict
# frozen_string_literal: true

# Installs the standalone Petika CLI for the host platform.
class Petika < Formula
  desc "Password manager with encrypted local vaults"
  homepage "https://github.com/k2patel/petika"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.1/petika-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "a35208abdbb9d57d7d6689fe9c1ef1a298b702cd7087759c01efcdad75a048d8"
    end
    on_intel do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.1/petika-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a4ce14290174dd124ac218a8db804f5f5b169522c5aed1a320215dbac93bbd9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.1/petika-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0cd61a4e8d66a0d9ac05c9f484891e50c06ac13155cef0a2af06a2dafca9d789"
    end
    on_intel do
      url "https://github.com/k2patel/petika/releases/download/cli-v0.1.1/petika-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22d6db56749d4da97a261cc6fa347cdeacd6d1a6d7dc30c876f374ff1baf5015"
    end
  end

  def install
    bin.install "petika"
    bin.install "petika-macos-unlock" if OS.mac?
    pkgshare.install "LICENSE", "THIRD_PARTY_NOTICES.txt", "build.json"
  end

  def caveats
    <<~EOS
      On supported Macs, enroll a local passphrase vault with:
        petika biometric enable
      Then request Touch ID for a command with:
        petika --biometric get NAME --reveal

      The CLI supports browser-approved account login and legacy passphrase or
      recipient vaults. Access to secrets in browser-passkey vaults requires
      per-action device approval integration, which is pending.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/petika --version")
    assert_path_exists bin/"petika-macos-unlock" if OS.mac?
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
