class Iometa < Formula
  desc "Just another IOKit class dumper"
  homepage "https://github.com/Siguza/iometa"
  url "https://github.com/Siguza/iometa.git"
  version "git"

  def install
    system "make"
    bin.install "iometa"
  end
end
