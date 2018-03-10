class Futurerestore < Formula
  desc "A hacked up idevicerestore wrapper, which allows specifying SEP and Baseband for restoring"
  homepage "https://github.com/tihmstar/futurerestore"
  url "https://github.com/tihmstar/futurerestore.git"
  version "git"

  head "https://github.com/tihmstar/tsschecker.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libzip"
  depends_on "libimobiledevice"
  depends_on "libfragmentzip"
  depends_on "libirecovery"

  def install
    mkdir "m4"
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--without-libipatcher",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
