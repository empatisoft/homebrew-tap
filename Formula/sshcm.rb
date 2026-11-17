class Sshcm < Formula
  desc "SSH Connection Manager: add, edit, remove and list the connections in ~/.ssh/config"
  homepage "https://github.com/empatisoft/sshcm"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.0/sshcm-aarch64-apple-darwin.tar.xz"
      sha256 "cc36f76e3797c0c282c1546d82a508d6d390a89544707f68831fa2bf6b83ac9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.0/sshcm-x86_64-apple-darwin.tar.xz"
      sha256 "2c92dca4b6bb67a95c2b013c9c1fc0bbf6ad82e14ff737e734f5f2353554fb6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.0/sshcm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "7b481d4268701618e38fae2fa8e0f141418a2d6e1cc3975b0818bc341a55aa03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.6.0/sshcm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3bba3d66210a4e678b28ab1e0820562c21bf091597cde2032468e22d0c8e3699"
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
