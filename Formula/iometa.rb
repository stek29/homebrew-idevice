class Iometa < Formula
  desc "Just another IOKit class dumper"
  homepage "https://github.com/Siguza/iometa"
  url "https://github.com/Siguza/iometa/archive/1.3.1.tar.gz"
  sha256 "31dd7bda4bbcf6d8fe6070143bff7bb84269304066e7ae232a075d613eadf8bb"

  def install
    system "make"
    bin.install "iometa"
  end
end
