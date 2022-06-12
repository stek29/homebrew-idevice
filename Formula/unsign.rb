class Unsign < Formula
  desc "Remove code signatures from OSX Mach-O binaries"
  homepage "http://www.woodmann.com/collaborative/tools/index.php/Unsign"
  url "https://github.com/steakknife/unsign.git",
    revision: "37151232e3a3186dc60a33c920c60044aa044788"
  version "0.11"
  head "https://github.com/steakknife/unsign.git"

  livecheck do
    url :url
    regex(%r{<strong>(\d+)</strong>\s*<spanaria-label="Commits}im)
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
