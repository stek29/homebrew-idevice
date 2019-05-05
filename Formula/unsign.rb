class Unsign < Formula
  desc "Remove code signatures from OSX Mach-O binaries"
  homepage "http://www.woodmann.com/collaborative/tools/index.php/Unsign"
  url "https://github.com/steakknife/unsign.git",
    :revision => "8cf356ca335d0709df3800e12ff07c25ec5ddd35"
  version "0.10"
  head "https://github.com/steakknife/unsign.git"

  def install
    system "make"
    bin.install "unsign"
  end
end
