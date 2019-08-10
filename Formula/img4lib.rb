class Img4lib < Formula
  desc "WIP code to deal with img4 files in a decent manner"
  homepage "https://github.com/xerub/img4lib"

  url "https://github.com/xerub/img4lib.git",
    :revision => "872230dbb1edfe2167c9db516db9f5e55cf48ba9"
  version "1.git-19"

  head "https://github.com/xerub/img4lib.git"

  depends_on "openssl"

  def install
    system "make"
    bin.install "img4"
  end
end
