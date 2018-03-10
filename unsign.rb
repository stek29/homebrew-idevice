class Unsign < Formula
  desc "Remove code signatures from OSX Mach-O binaries"
  homepage "http://www.woodmann.com/collaborative/tools/index.php/Unsign"
  url "https://github.com/steakknife/unsign.git"
  version "0.1"

  def install
    system "make"
    bin.install "unsign"
  end
end

