class Iometa < Formula
  desc "Extracts C++ class runtime information from arm64 Darwin kernel"
  homepage "https://github.com/Siguza/iometa"
  url "https://github.com/Siguza/iometa/archive/1.6.6.tar.gz"
  sha256 "147c88729d897e78688ab969ffb009426d9f1e21895bab6e4e54baed4699dd30"
  license "MPL-2.0-no-copyleft-exception"
  head "https://github.com/Siguza/iometa.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "386fcdaf924b5c9607535d0ef0bd959b6e41a7eb5a0d6776b512489f5ad1fa35"
    sha256 cellar: :any_skip_relocation, big_sur:  "c66f61e30af245b7a51ece11e821da0f6ea0c35001a1b911c634d405c331ab95"
    sha256 cellar: :any_skip_relocation, catalina: "7e3f2635156f2119132d14dbaf64f1a1b291077b318b80f79e56ce19c0949dbe"
  end

  def install
    system "make"
    bin.install "iometa"
  end
end
