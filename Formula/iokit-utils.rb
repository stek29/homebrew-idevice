class IokitUtils < Formula
  desc "Little dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils/archive/1.3.0.tar.gz"
  sha256 "9df7dbb0ab78425d82370f87dffaa25161aa79a9ab13b1bc39797f03731563d9"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "ec0596c02b54e260d050ec75a417be8dcbeecad650570227e018b573e34aa277"
    sha256 cellar: :any_skip_relocation, big_sur:  "0ca1ef7c69ac3209298b1b6e21865b2b10feeeca3cd9c31ecb49ea633a93e2a1"
    sha256 cellar: :any_skip_relocation, catalina: "5a1562a863de6860dc9cf352efec3f88e143f8ad321f20f1b50d1acfc9f4b307"
  end

  def install
    system "make"
    cd "bin" do
      bin.install "ioclass"
      bin.install "ioprint"
      bin.install "ioscan"
    end
  end
end
