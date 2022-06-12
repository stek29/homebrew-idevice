class LibimobiledeviceGlue < Formula
  desc "Common code used by the libimobiledevice project"
  homepage "https://github.com/libimobiledevice/libimobiledevice-glue"
  url "https://github.com/libimobiledevice/libimobiledevice-glue.git",
    revision: "d2ff7969dcd0a12e4f18f63dab03e6cd03054fcb"
  version "1.0.0-35-gd2ff796"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libimobiledevice-glue.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "1b217a06ea71672717a87df850c67ca59962442a01f603ba4ea8883edbf52d75"
    sha256 cellar: :any, big_sur:  "309351efbaa9f40b2475673f411f769a515de36335c8350c0fd57b1a63f5bf93"
    sha256 cellar: :any, catalina: "16d7b3449aa808b0f246c4be2a5210b385b68f77a2f74646b378cf768d27981b"
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

  test do
    system "true"
  end
end
