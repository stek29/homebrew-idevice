class Futurerestore < Formula
  desc "Hacked up idevicerestore wrapper"
  homepage "https://github.com/tihmstar/futurerestore"
  url "https://github.com/tihmstar/futurerestore.git",
    :revision => "88861b6128b7ae736bad4880e07f9026e025a537"
  version "182"

  head "https://github.com/tihmstar/futurerestore.git"

  option "without-libipatcher", "Don't bundle libipatcher; disables Odysseus support"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libfragmentzip"
  depends_on "libimobiledevice"
  depends_on "libirecovery"
  depends_on "libplist"
  depends_on "libzip"
  depends_on "libipatcher" => :optional

  def fix_tihmstar
    File.symlink "LICENSE", "COPYING"

    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

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
