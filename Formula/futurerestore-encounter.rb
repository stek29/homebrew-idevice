class FuturerestoreEncounter < Formula
  desc "iOS upgrade and downgrade tool utilizing SHSH blobs (unofficial fork supporting iOS 11 and newer devices)"
  homepage "https://github.com/encounter/futurerestore"
  url "https://github.com/encounter/futurerestore.git",
    :tag => "v173",
    :revision => "a0113a4e46bfd00962cd25e3af548fc8b0bd21fd"

  head "https://github.com/encounter/futurerestore.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libzip"
  depends_on "libimobiledevice"
  depends_on "libfragmentzip"
  depends_on "libirecovery"

  conflicts_with "futurerestore", :because => "it's an unofficial fork"

  option "without-libipatcher", "Don't bundle libipatcher; disables Odysseus support"

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

    # we don't need libjssy.a/fragmentzip/idevicerestore.1
    # system "make", "install"

    # fix fragmentzip issue
    # See https://github.com/tihmstar/tsschecker/commit/f8644fabb1adb04fc0ee42860fd7d2e0469823dc#commitcomment-28027109
    f = MachO::MachOFile.new("futurerestore/.libs/futurerestore")
    old_name = f.linked_dylibs.select { |fn| fn =~ /libfragmentzip/ } .first
    new_name = MachO::MachOFile.new("#{Formula["libfragmentzip"].opt_lib}/libfragmentzip.dylib").dylib_id
    f.change_install_name(old_name, new_name)
    f.write("futurerestore-fixed")

    bin.install "futurerestore-fixed" => "futurerestore"
  end

end
