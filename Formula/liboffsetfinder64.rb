class Liboffsetfinder64 < Formula
  desc "Finds offsets, patches, parses Mach-O and IMG4"
  homepage "https://github.com/Cryptiiiic/liboffsetfinder64"
  url "https://github.com/Cryptiiiic/liboffsetfinder64.git",
    revision: "8d4fe0e495708995dce96445744654c89203f68a"
  version "152"
  license "LGPL-2.1-or-later"
  revision 1
  head "https://github.com/Cryptiiiic/liboffsetfinder64.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    sha256 cellar: :any, monterey: "057e00632f99dad8298c94462305d4f15be7204b9bf6b131615fb8841f24d023"
    sha256 cellar: :any, big_sur:  "da0477616884a55f9aa2a12e658d5e8947173e2213ff4cdf0d641742f98f96b7"
    sha256 cellar: :any, catalina: "0749c27ea04e2aaf9cb9da41b2e3b99346e942fb57a22861746e3d3769139db9"
  end

  keg_only "it's an utility library for various project of tihmstar"

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

  def caveats
    <<~EOS
      this is not the "official" tihmstar/liboffsetfinder64, but a maintained fork by Cryptiiiic
    EOS
  end
end
