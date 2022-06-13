class Unsign < Formula
  desc "Remove code signatures from Mach-O binaries"
  homepage "https://web.archive.org/web/20200214131522/http://www.woodmann.com/collaborative/tools/index.php/Unsign"
  url "https://github.com/steakknife/unsign.git",
    revision: "37151232e3a3186dc60a33c920c60044aa044788"
  version "0.11"
  license "ISC"
  head "https://github.com/steakknife/unsign.git"

  livecheck do
    url :url
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
    strategy :page_match do |page|
      v = page.match(regex)&.captures&.first
      "0.#{v}" if v
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "dd7b71acb531c6bff145bc1357b93dd0e3693b0e86628726c5bbabe4dd2fe141"
    sha256 cellar: :any_skip_relocation, big_sur:  "86f62038b2efa03f4c40e9686e7db035d4eac0a78665f5bd29ff3b8f0ba39dee"
    sha256 cellar: :any_skip_relocation, catalina: "16896f3555c2352d623f382affee515dac8f388d56155352b59777f31485b8b5"
  end

  def install
    system "make"
    bin.install "unsign"
  end
end
