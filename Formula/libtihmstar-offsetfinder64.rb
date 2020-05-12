class LibtihmstarOffsetfinder64 < Formula
  desc "Finds offsets, patches, parses Mach-O and IMG4"
  homepage "https://github.com/tihmstar/liboffsetfinder64"
  url "https://github.com/tihmstar/liboffsetfinder64.git",
    :tag => "118"
  head "https://github.com/tihmstar/liboffsetfinder64.git"

  keg_only "its an utility library for tihmstar's projects and isnt used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libplist"
  depends_on "libtihmstar-general"
  depends_on "libzip"
  depends_on "openssl@1.1"

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
