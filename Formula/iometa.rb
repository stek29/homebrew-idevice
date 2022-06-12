class Iometa < Formula
  desc "Just another IOKit class dumper"
  homepage "https://github.com/Siguza/iometa"
  url "https://github.com/Siguza/iometa/archive/1.6.6.tar.gz"
  sha256 "147c88729d897e78688ab969ffb009426d9f1e21895bab6e4e54baed4699dd30"

  def install
    system "make"
    bin.install "iometa"
  end
end
