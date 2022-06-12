class Libipatcher < Formula
  desc "Convinient wrapper for iBoot32Patcher"
  homepage "https://github.com/tihmstar/libipatcher"
  url "https://github.com/tihmstar/libipatcher.git",
    revision: "0b2f79ff0917ef9b8a92475d93d9466b23fc2322"
  version "82"
  head "https://github.com/tihmstar/libipatcher.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  keg_only "because I don't want this in /usr/local"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build # xpwn
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libplist"
  depends_on "libpng"
  depends_on "libtihmstar-general"
  depends_on "libtihmstar-offsetfinder64"
  depends_on "libzip"
  depends_on "openssl@1.1"

  resource "xpwn" do
    url "https://github.com/tihmstar/xpwn/archive/76742fc7b0ea556f005058274e9b69f40c56aef7.tar.gz"
    sha256 "17574e8d886373f7d3f175ab92f7c40613724793a4fc11f4f60ce149ae770ca9"
  end

  def build_libxpwn
    xpwndir = "#{buildpath}/external/xpwn"
    mkdir_p xpwndir

    resource("xpwn").stage do
      inreplace "ipsw-patch/CMakeLists.txt", "powerpc-apple-darwin8-libtool", "libtool"

      # OpenSSL 1.1.0 fix
      inreplace "includes/dmg/filevault.h", "HMAC_CTX", "HMAC_CTX *"

      mkdir "builddir" do
        system "cmake", "..", *std_cmake_args
        system "make", "libXPwn.a", "common"
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

