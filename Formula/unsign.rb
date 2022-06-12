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

  def install
    system "make"
    bin.install "unsign"
  end
end
