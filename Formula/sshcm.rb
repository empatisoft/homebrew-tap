class Sshcm < Formula
  desc "SSH Connection Manager: add, edit, remove and list the connections in ~/.ssh/config"
  homepage "https://github.com/empatisoft/sshcm"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.1.0/sshcm-aarch64-apple-darwin.tar.xz"
      sha256 "8c57dea70448a9e26d1edf8d2712274ffeaaf5b47cbb7e846af9c14117a0496d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.1.0/sshcm-x86_64-apple-darwin.tar.xz"
      sha256 "0ea5bd89aebe11a405e0a7efc2c4460d47b5e228182d6fa2edc02ac1b2d2f503"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.1.0/sshcm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "42e556b07aa3d5474487e415d755b027e33a64ffa2d89c0957f2e4a59098dc55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.1.0/sshcm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "32bd3ff9cab94880c08ce6a3d55f1d61752d5c860429febc132f061e57f4314e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sshcm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sshcm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sshcm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sshcm"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
