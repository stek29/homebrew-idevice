class Libideviceactivation < Formula
  desc "Library handle the activation process of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/libideviceactivation.git",
    revision: "75505b75816691e1ff651fb55bfc6aaa7170ba3f"
  version "1.1.1-12-g75505b7"

  head "https://github.com/libimobiledevice/libideviceactivation.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libplist"
  depends_on "stek29/idevice/libusbmuxd"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
