class Img4lib < Formula
  desc "WIP code to deal with img4 files in a decent manner"
  homepage "https://github.com/xerub/img4lib"

  url "https://github.com/xerub/img4lib.git",
    revision: "e6a7f7bda2cb209188c989500308d59d93622057"
  version "1.git-17"

  head "https://github.com/xerub/img4lib.git"

  depends_on "openssl"

  def install
    system "make"
    bin.install "img4"
  end
end
