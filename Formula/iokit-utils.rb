class IokitUtils < Formula
  desc "Dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils/archive/1.3.0.tar.gz"
  sha256 "9df7dbb0ab78425d82370f87dffaa25161aa79a9ab13b1bc39797f03731563d9"

  def install
    system "make"
    cd "bin" do
      bin.install "ioclass"
      bin.install "ioprint"
      bin.install "ioscan"
    end
  end
end
