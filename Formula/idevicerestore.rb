class Idevicerestore < Formula
  desc "Restore/upgrade firmware of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/idevicerestore.git"
  version "git0"

  head "https://github.com/libimobiledevice/idevicerestore.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libimobiledevice"
  depends_on "libirecovery"
  depends_on "libplist"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
