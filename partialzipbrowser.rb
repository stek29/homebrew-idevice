class Partialzipbrowser < Formula
  desc "a tool for browsing and downloading files from zip files on remote webserver"
  homepage "https://github.com/tihmstar/partialZipBrowser"
  url "https://github.com/tihmstar/partialZipBrowser.git"
  version "1.0.1"

  head "https://github.com/tihmstar/partialZipBrowser.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libzip"
  depends_on "libfragmentzip"

  def install
    mkdir "m4"
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
