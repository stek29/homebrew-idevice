class Libfragmentzip < Formula
  desc "Library for downloading single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git",
    :revision => "cb3db36763f3ebbe6d9612b6b0669fefddb689f2"
  version "45"
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
