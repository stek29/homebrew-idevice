class Libfragmentzip < Formula
  desc "A library allowing to download single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git"
  version "1.0"

  head "https://github.com/tihmstar/libfragmentzip.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libzip"

  def install
    mkdir "m4"
    cp "LICENSE", "COPYING"
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
