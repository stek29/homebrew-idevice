class Futurerestore < Formula
  desc "Hacked up idevicerestore wrapper"
  homepage "https://github.com/tihmstar/futurerestore"
  url "https://github.com/tihmstar/futurerestore.git",
    :revision => "4a8cabbe556d264df17379372f01f0523ba8d6c4"
  version "156"

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
  depends_on "libipatcher" => :optional

  def fix_tihmstar
    if File.symlink?("COPYING")
      rm "COPYING"
      touch "LICENSE"
      cp "LICENSE", "COPYING"
    end

    files = %w[setBuildVersion.sh autogen.sh configure.ac]
    inreplace files.select { |f| File.exist? f },
      "$(git rev-list --count HEAD)",
      version.to_s.gsub(/[^\d]/, ""),
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
