class Sshcm < Formula
  desc "SSH Connection Manager: add, edit, remove and list the connections in ~/.ssh/config"
  homepage "https://github.com/empatisoft/sshcm"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.5.0/sshcm-aarch64-apple-darwin.tar.xz"
      sha256 "8279f5ac78e2c83cba5219bc4704c649d9ba7dcd97272a0ece55a703b54353ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.5.0/sshcm-x86_64-apple-darwin.tar.xz"
      sha256 "60e08d3a438eed3544e72f3a544d350d2cd198f72f6a154bd5ade6efcf9da33d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.5.0/sshcm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6c7f93b6b4e632222d5e45884376bcdd5d1701ac1f4463e79a10842b984089b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.5.0/sshcm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "283558e5f83be3ec1f196a811d176fcb25018dab8a9ad4259f1e8c504ed14dd0"
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
