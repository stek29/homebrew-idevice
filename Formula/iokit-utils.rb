class IokitUtils < Formula
  desc "Dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils.git",
    tag: "1.2.3",
    revision: "71a84147c595388a49d40de6bfbadb0aa78790cf"

  def install
    system "make"
    cd "bin" do
      bin.install "ioclass"
      bin.install "ioprint"
      bin.install "ioscan"
    end
  end
end
