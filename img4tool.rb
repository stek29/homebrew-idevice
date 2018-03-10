class Img4tool < Formula
  desc "A tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  version 'git'
  url "https://github.com/tihmstar/img4tool.git"
  head "https://github.com/tihmstar/img4tool.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "openssl"

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
