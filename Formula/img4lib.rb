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

  # libcompression is provided since macOS 10.11
  # according to https://developer.apple.com/documentation/compression
  # on older versions lzfse is needed
  on_macos do
    depends_on "lzfse" if MacOS.version < :el_capitan
  end

  on_linux do
    depends_on "lzfse"
    depends_on "openssl@1.1"
  end

  def install
    args = []
    if OS.mac?
      args << "COMMONCRYPTO=1"

      if MacOS.version >= :el_capitan
        # remove libcompression check – it's expected to be present on recent macOS versions
        inreplace "Makefile",
          "$(wildcard /usr/lib/libcompression.dylib)", "x",
          false
      end
    end

    system "make", *args
    bin.install "img4"
  end
end
