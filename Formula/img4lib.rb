class Img4lib < Formula
  desc "WIP code to deal with img4 files in a decent manner"
  homepage "https://github.com/xerub/img4lib"

  url "https://github.com/xerub/img4lib.git",
    :revision => "ed6a79670cf4460488d83702019e7bde7577032f"
  version "1.git-31"

  head "https://github.com/xerub/img4lib.git"

  depends_on "openssl"

  def install
    system "make"
    bin.install "img4"
  end
end
