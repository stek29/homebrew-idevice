class Libirecovery < Formula
  desc "Library for communication to iBoot/iBSS on iOS devices via USB"
  homepage "https://github.com/libimobiledevice/libirecovery"
  url "https://github.com/libimobiledevice/libirecovery.git"
  version "git0"

  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "autoconf" => :build

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
