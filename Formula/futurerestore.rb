class Futurerestore < Formula
  desc "Hacked up idevicerestore wrapper"
  homepage "https://github.com/tihmstar/futurerestore"
  url "https://github.com/tihmstar/futurerestore.git"
  version "git0"

  head "https://github.com/tihmstar/futurerestore.git"

  option "without-libipatcher", "Don't bundle libipatcher; disables Odysseus support"

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
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
    ]
    args << "--without-libipatcher" if build.without? "libipatcher"
    system "./autogen.sh", *args
    system "make"

    # we don't need libjssy.a and idevicerestore.1
    # system "make", "install"
    bin.install "futurerestore/futurerestore" => "futurerestore"
  end
end
