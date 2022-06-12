class Img4lib < Formula
  desc "Some WIP to deal with img4 files in a decent manner"
  homepage "https://github.com/xerub/img4lib"

  url "https://github.com/xerub/img4lib.git",
    revision: "69772c72f3c08f021ec9fa4c386f2b3df60a38b7"
  version "1.0-7-g69772c7"

  head "https://github.com/xerub/img4lib.git"

  livecheck do
    skip "upstream has no tags"
  end

  depends_on "openssl@1.1"

  def install
    system "make"
    bin.install "img4"
  end
end
