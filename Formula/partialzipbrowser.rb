class Partialzipbrowser < Formula
  desc "Tool for zip files on remote webserver"
  homepage "https://github.com/tihmstar/partialZipBrowser"
  url "https://github.com/tihmstar/partialZipBrowser.git",
    :tag => "36"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libtihmstar-general"

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
    system "make", "install"
  end
end
