class Lps < Formula
  desc "List & manage processes by listening port, grouped by project"
  homepage "https://github.com/linhh-phv/lps"
  url "https://github.com/linhh-phv/lps/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e6fe7a6cf8d7c15b1b4f47ae6a3419f0fd0808e4424c532b51c4da136ce0a396"
  license "MIT"
  version "0.1.0"

  # lsof, ps, awk, grep, sed are all standard on macOS and Linux —
  # no Homebrew dependencies needed.

  def install
    detect_and_clean_duplicates!
    bin.install "lps"
  end

  # Refuse to install (or auto-clean) any non-brew lps already on disk,
  # so the user ends up with exactly one copy after `brew install`.
  def detect_and_clean_duplicates!
    candidates = [
      "/usr/local/bin/lps",
      "/usr/bin/lps",
      "#{Dir.home}/bin/lps",
      "#{Dir.home}/.local/bin/lps",
    ]

    conflicts = candidates.select do |path|
      next false unless File.exist?(path) || File.symlink?(path)
      # Skip anything that already points into a Cellar (e.g. an old brew symlink).
      next false if File.symlink?(path) && File.realpath(path).include?("/Cellar/")
      true
    end

    return if conflicts.empty?

    conflicts.each do |path|
      File.delete(path)
      opoo "Removed existing non-brew lps install: #{path}"
    rescue Errno::EACCES, Errno::EPERM
      odie <<~MESSAGE
        Found an existing lps install at:
            #{path}

        This formula cannot remove it (permission denied). To avoid a
        duplicate install, remove it first and re-run:

            sudo rm #{path}
            brew install linhh-phv/tap/lps
      MESSAGE
    end
  end

  test do
    assert_match "lps v#{version}", shell_output("#{bin}/lps version")
    assert_match "USAGE", shell_output("#{bin}/lps help")
  end
end
