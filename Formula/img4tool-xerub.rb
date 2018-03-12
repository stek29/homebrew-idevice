class Img4toolXerub < Formula
  desc "tool for image4 and der"
  homepage "https://github.com/xerub/img4tool"

  url "https://github.com/xerub/img4tool.git"
  version "git0"

  head "https://github.com/xerub/img4tool.git"

  depends_on "openssl"
  depends_on "lzfse"

  def install
    system "make"
    bin.install "img4"
  end
end
