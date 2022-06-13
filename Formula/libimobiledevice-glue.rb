class LibimobiledeviceGlue < Formula
  desc "Common code used by the libimobiledevice project"
  homepage "https://github.com/libimobiledevice/libimobiledevice-glue"
  url "https://github.com/libimobiledevice/libimobiledevice-glue.git",
    revision: "d2ff7969dcd0a12e4f18f63dab03e6cd03054fcb"
  version "1.0.0-35-gd2ff796"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libimobiledevice-glue.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 2
    sha256 cellar: :any, monterey: "66d56c11d5e4722934e410ebd4431b186f44f079dee6fc6a328542164b7f76db"
    sha256 cellar: :any, big_sur:  "eda04bf0f3c748515b8caf192e459d002e25e4d6704664cb4dd94d9e5a1342a9"
    sha256 cellar: :any, catalina: "4bd2571e65b7fba3f9af2ca7f8dd8c0366bb37b001480479b095745be7d8153c"
  end

  keg_only "it's an utility library for libimobiledevice"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "stek29/idevice/libplist"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
