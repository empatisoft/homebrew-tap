class Sshcm < Formula
  desc "SSH Connection Manager: add, edit, remove and list the connections in ~/.ssh/config"
  homepage "https://github.com/empatisoft/sshcm"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.1/sshcm-aarch64-apple-darwin.tar.xz"
      sha256 "5dc82b6797d6a77ee98a88d5b38abbcb1e98587650227c722fb65c3b5be73ff6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.1/sshcm-x86_64-apple-darwin.tar.xz"
      sha256 "4280bada581fae65c62a9026891a3a2fd6029d7c22475e0dc03f7d23b5a0daa8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.1/sshcm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6a00218ffe2abc5edbb6bdaed73909ee2bf6efb3c5b02e3a06c3e049e003ef41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.1/sshcm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c467841dade398f6c68f610595d9260593ed0ff8cf538bcb083b3f05ac23a317"
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
