class LibtihmstarOffsetfinder64 < Formula
  desc "Finds offsets, patches, parses Mach-O and IMG4"
  homepage "https://github.com/tihmstar/liboffsetfinder64"
  url "https://github.com/tihmstar/liboffsetfinder64.git",
    revision: "e093adefc92e9c3b56d8f5989835f3247ea0e575"
  version "133"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/liboffsetfinder64.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "f9d63147c98fd526faa1a5b74c7aecafdd54aa2dc966812b8ecc1b91326607ff"
    sha256 cellar: :any, big_sur:  "58abfb97a94aab2cf3954653ae602c9d0bebcaaa539b6b6ad292744f5178fa4c"
    sha256 cellar: :any, catalina: "7247676f8f46b09fb36081367d1856ac6d81e0cf463959a3ded155a155349881"
  end

  keg_only "its an utility library for tihmstar's projects and isnt used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libtihmstar-general"
  depends_on "libzip"
  depends_on "stek29/idevice/libinsn"
  depends_on "stek29/idevice/libplist"

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
