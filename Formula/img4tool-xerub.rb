class Img4toolXerub < Formula
  desc "tool for image4 and der"
  homepage "https://github.com/xerub/img4tool"

  url "https://github.com/xerub/img4tool.git",
    revision: "928925a7581c226dc211a64f0d00280a3e7ae539"
  version "0.8-retired"

  head "https://github.com/xerub/img4tool.git"

  depends_on "openssl"
  depends_on "lzfse"

  def install
    system "make"
    bin.install "img4"
  end
end
