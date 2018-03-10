class IokitUtils < Formula
  desc "Dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils.git"
  version "git"

  def install
    system "make"
    cd "bin" do
      bin.install "ioclass"
      bin.install "ioprint"
      bin.install "ioscan"
    end
  end
end

