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

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "70780df7edeb749a447ee49d22fef640505483b83bd19e67cde26c087f6c7095"
    sha256 cellar: :any_skip_relocation, big_sur:  "ccc8d49374d31a21e8e2caeb953093134ff246a4923efb76a9cfe0cb1199ce98"
    sha256 cellar: :any_skip_relocation, catalina: "3e6a09ea5d152a9b8aef117bfdb7709d8113e6c2968bd92cff641f1826074d14"
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
