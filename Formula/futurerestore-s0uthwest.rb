class FuturerestoreS0uthwest < Formula
  desc "iOS up/downgrade tool - unofficial fork"
  homepage "https://github.com/s0uthwest/futurerestore"

  # Not using tags because s0uthwest tends to delete them
  url "https://github.com/s0uthwest/futurerestore.git",
    :revision => "536fee9e67dbc2842b2e461bb0d23cfd0f6cf903"
  version "246"

  head "https://github.com/s0uthwest/futurerestore.git"

  option "without-libipatcher", "Don't bundle libipatcher; disables Odysseus support"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libimobiledevice"
  depends_on "libirecovery"
  depends_on "libplist"
  depends_on "libzip"
  depends_on "libipatcher" => :optional

  conflicts_with "futurerestore", :because => "it's an unofficial fork"

  def fix_tihmstar
    mkdir "m4"

    files = %w[setBuildVersion.sh configure.ac]
    inreplace files.select { |f| File.exist? f },
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false

    # See https://github.com/tihmstar/partialZipBrowser/commit/8c70e7ff11c3d73bf6d0047f82cb3db7e874cbfc#r32043428
    inreplace "autogen.sh",
      "automake",
      "automake --foreign",
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

    # we don't need libjssy.a/fragmentzip/idevicerestore.1
    # system "make", "install"
    bin.install "futurerestore/futurerestore"
  end
end
