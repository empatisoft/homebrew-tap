class Sshcm < Formula
  desc "SSH Connection Manager: add, edit, remove and list the connections in ~/.ssh/config"
  homepage "https://github.com/empatisoft/sshcm"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.3.1/sshcm-aarch64-apple-darwin.tar.xz"
      sha256 "a475ab56504a5e34155d6d33e803694a48f91ee17211a0a48b4596790182d8a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.3.1/sshcm-x86_64-apple-darwin.tar.xz"
      sha256 "bb5c66368d6bab53e4c4c50cae574d84514f2d8760c31e10e8b97c5efe8946d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.3.1/sshcm-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8e4f293a75ca2de2866942f93458e2105b4515b69f27ded0f272491f0a82af59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/empatisoft/sshcm/releases/download/v0.3.1/sshcm-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c5c44133faba0cfd8c6326e33c8d719ed7e8fe20802b5da13f40fa4aa5f853cf"
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
