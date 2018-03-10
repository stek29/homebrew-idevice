class Tsschecker < Formula
  desc "Tool to check tss signing status of various devices"
  homepage "https://github.com/tihmstar/tsschecker"
  url "https://github.com/tihmstar/tsschecker/archive/v212.tar.gz"
  sha256 "cdcaa81bca0f4725f646ed95c8e7f1565492949e8b9c5c7607e8759fed68b6f6"

  head "https://github.com/tihmstar/tsschecker.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libfragmentzip"
  depends_on "libirecovery"

  def install
    mkdir "m4"
    cp "LICENSE", "COPYING"
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    # No, thanks, we dont need libjssy
    # system "make", "install"
    # rm_rf "#{lib}/libjssy.a"
    bin.install "tsschecker/tsschecker" => "tsschecker"
  end
end
