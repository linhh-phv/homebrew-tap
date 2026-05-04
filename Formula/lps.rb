class Lps < Formula
  desc "List & manage processes by listening port, grouped by project"
  homepage "https://github.com/linhh-phv/lps"
  url "https://github.com/linhh-phv/lps/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "dd4d750b6a9f650f67b7dd3add988498782a4113f710c1e8ccd8c53b074a5689"
  license "MIT"
  version "0.1.0"

  depends_on "lsof" => :recommended

  def install
    bin.install "lps"
  end

  test do
    assert_match "lps v#{version}", shell_output("#{bin}/lps version")
    assert_match "USAGE", shell_output("#{bin}/lps help")
  end
end
