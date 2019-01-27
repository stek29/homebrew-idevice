class Partialzipbrowser < Formula
  desc "Tool for zip files on remote webserver"
  homepage "https://github.com/tihmstar/partialZipBrowser"
  url "https://github.com/tihmstar/partialZipBrowser.git",
    revision: "8c70e7ff11c3d73bf6d0047f82cb3db7e874cbfc"
  version "32"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libzip"
  depends_on "libfragmentzip"

  def fix_tihmstar
    mkdir "m4"
    cp "LICENSE", "COPYING"

    files = %w[configure.ac]
    inreplace files.select { |f| File.exist? f },
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false

    # See https://github.com/tihmstar/partialZipBrowser/commit/8c70e7ff11c3d73bf6d0047f82cb3db7e874cbfc#r32043428
    # tihmstar didn't do anything, even after me reaching out to him on
    # twitter
    inreplace "autogen.sh",
      "automake",
      "automake --foreign",
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
