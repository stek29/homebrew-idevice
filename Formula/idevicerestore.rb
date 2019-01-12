class Idevicerestore < Formula
  desc "Restore/upgrade firmware of iOS devices"
  homepage "http://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/idevicerestore.git"
  version "git0"

  head "https://github.com/libimobiledevice/idevicerestore.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libfragmentzip"
  depends_on "libirecovery"
  depends_on "libimobiledevice"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
