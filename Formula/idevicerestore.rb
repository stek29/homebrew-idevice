class Idevicerestore < Formula
  desc "Restore/upgrade firmware of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/idevicerestore.git",
    revision: "f80a876b3598de4eb551bafcb279947c527fae33"
  version "1.0.0-95-gf80a876"

  head "https://github.com/libimobiledevice/idevicerestore.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "to avoid conflicts with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libzip"
  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libirecovery"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
