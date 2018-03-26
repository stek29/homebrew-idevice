class Libipatcher < Formula
  desc "Convinient wrapper for iBoot32Patcher"
  homepage "https://github.com/tihmstar/libipatcher"
  url "https://github.com/tihmstar/libipatcher.git",
    :revision => "37c38e3ab3390c96ae26d08aa4330771aca20ea2"
  version "47"

  head "https://github.com/tihmstar/libipatcher.git"
  keg_only "because I don't want this in /usr/local"

  depends_on "cmake" => :build # xpwn
  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libpng"
  depends_on "openssl"
  depends_on "libusb"

  resource "xpwn" do
    url "https://github.com/tihmstar/xpwn.git"
  end

  def build_libxpwn
    xpwndir = "#{buildpath}/external/xpwn"
    mkdir_p xpwndir

    resource("xpwn").stage do
      inreplace "ipsw-patch/CMakeLists.txt", "powerpc-apple-darwin8-libtool", "libtool"

      mkdir "builddir" do
        system "cmake", "..", *std_cmake_args
        system "make", "libXPwn.a", "common"
        cp "ipsw-patch/libxpwn.a", xpwndir
        cp "common/libcommon.a", xpwndir
      end

      cp_r "includes", xpwndir
    end
  end

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

    build_libxpwn

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  patch :p0, :DATA
end

__END__
diff --git libipatcher/Makefile.am libipatcher/Makefile.am
--- libipatcher/Makefile.am
+++ libipatcher/Makefile.am
@@ -1,6 +1,9 @@
 AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/external/iBoot32Patcher -I$(top_srcdir)/external/jssy/jssy/ $(libpng_CFLAGS)
 AM_LDFLAGS = -L$(top_srcdir)/libipatcher -L/usr/local/lib/ -lcommon -lxpwn $(libpng_LIBS) $(openssl_LIBS)

+AM_CFLAGS += -I$(includedir) -I$(top_srcdir)/external/xpwn/includes
+AM_LDFLAGS += -L$(libdir) -L$(top_srcdir)/external/xpwn
+
 noinst_LTLIBRARIES = libiBoot32Patcher.la libjssy.la
 lib_LTLIBRARIES = libipatcher.la

