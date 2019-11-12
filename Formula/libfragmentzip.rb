class Libfragmentzip < Formula
  desc "Library for downloading single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git",
    :revision => "7951fa1e40415a630cd2d4401b2ebb261b0a46a2"
  version "53"
  head "https://github.com/tihmstar/libfragmentzip.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libzip"

  def fix_tihmstar
    mkdir "m4"
    cp "LICENSE", "COPYING"

    files = %w[configure.ac]
    inreplace files.select { |f| File.exist? f },
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
