class Libipatcher < Formula
  desc "Convinient wrapper for iBoot32Patcher"
  homepage "https://github.com/Cryptiiiic/libipatcher"
  url "https://github.com/Cryptiiiic/libipatcher.git",
    revision: "1e855d70c84419014e363bdbcaead7b145fe3e1f"
  version "88"
  license "LGPL-2.1-or-later"
  revision 2
  head "https://github.com/Cryptiiiic/libipatcher.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "4fdd90b93dac1082b7b08e239244bc4e470f534879f482709fdbdc2c75189e7a"
    sha256 cellar: :any, big_sur:  "a1a1d1dce68435ec74321cc0a778bc62a8fc76b22f5712ec7e334e1af77a03f2"
    sha256 cellar: :any, catalina: "5f269cf31124bfe5ab7805ba8cab3255495a3742b42dd03a3312db01f9f2f085"
  end

  keg_only "because I don't want this in /usr/local"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build # xpwn
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "liboffsetfinder64"
  depends_on "libpng"
  depends_on "libtihmstar-general"
  depends_on "libzip"
  depends_on "openssl@1.1"
  depends_on "stek29/idevice/libplist"

  resource "xpwn" do
    url "https://github.com/nyuszika7h/xpwn/archive/f6baa79ee898657229c71c8fbcc2c7e39f31f35a.tar.gz"
    sha256 "807e79e2115a43b2ce626086d67e25f0b4b5a1ff4da6ae9253ef102dc7a4b0ad"
  end

  def build_libxpwn
    xpwndir = "#{buildpath}/external/xpwn"
    mkdir_p xpwndir

    resource("xpwn").stage do
      mkdir "builddir" do
        system "cmake", "..", *std_cmake_args
        system "make", "xpwn", "common"
        cp "ipsw-patch/libxpwn.a", xpwndir
        cp "common/libcommon.a", xpwndir
      end

      cp_r "includes", xpwndir
    end
  end

  # To add xpwndir to include/lib paths
  patch :p0, :DATA

  def fix_tihmstar
    File.symlink "LICENSE", "COPYING"
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar
    build_libxpwn

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      this is not the "official" tihmstar/libipatcher, but a maintained fork by Cryptiiiic

      it also bundles nyuszika7h's fork of xpwn
    EOS
  end
end

__END__
diff --git libipatcher/Makefile.am libipatcher/Makefile.am
--- libipatcher/Makefile.am
+++ libipatcher/Makefile.am
@@ -1,6 +1,9 @@
 AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/external/iBoot32Patcher -I$(top_srcdir)/external/jssy/jssy/ $(libpng_CFLAGS) $(openssl_CFLAGS) $(libimg4tool_CFLAGS) $(liboffsetfinder64_CFLAGS) $(libgeneral_CFLAGS)
 AM_LDFLAGS = -L$(top_srcdir)/libipatcher -L/usr/local/lib/ -lcommon -lxpwn $(libpng_LIBS) $(openssl_LIBS) $(libimg4tool_LIBS) $(liboffsetfinder64_LIBS) $(libgeneral_LIBS)

+AM_CFLAGS += -I$(includedir) -I$(top_srcdir)/external/xpwn/includes
+AM_LDFLAGS += -L$(libdir) -L$(top_srcdir)/external/xpwn
+
 noinst_LTLIBRARIES = libiBoot32Patcher.la libjssy.la
 lib_LTLIBRARIES = libipatcher.la

