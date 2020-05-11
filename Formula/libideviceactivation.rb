class Libideviceactivation < Formula
  desc "Library handle the activation process of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/libideviceactivation/archive/1.1.0.tar.gz"
  sha256 "17fb29a285327aecf33b701a4fa3e1193bd63cabd06cae7121cf870756b75720"

  head "https://github.com/libimobiledevice/libideviceactivation.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice"
  depends_on "libplist"
  depends_on "libusbmuxd"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
