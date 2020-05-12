class Libfragmentzip < Formula
  desc "Library for downloading single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git",
    :tag => "60"
  head "https://github.com/tihmstar/libfragmentzip.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libtihmstar-general"
  depends_on "libzip"

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
