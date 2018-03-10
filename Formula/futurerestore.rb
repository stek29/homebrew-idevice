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
    mkdir_p "m4"

    if File.symlink?("COPYING")
      rm "COPYING"
      if File.exist?("LICENSE")
        cp "LICENSE", "COPYING"
      else
        touch "COPYING"
      end
    end

    vers = version.to_s.sub /[^\d]/, ""
    inreplace(File.exist?("setBuildVersion.sh") ? "setBuildVersion.sh" : "autogen.sh", "$(git rev-list --count HEAD)", vers)
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
