class Liboffsetfinder64 < Formula
  desc "A 64bit offsetfinder. It finds offsets, patches, parses Mach-O and even supports IMG4"
  homepage "https://github.com/tihmstar/liboffsetfinder64"
  url "https://github.com/tihmstar/liboffsetfinder64.git",
    :revision => "8dd890defcf2f35b3f1ef45fda83b3a577147c5a"
  version "104"
  head "https://github.com/tihmstar/liboffsetfinder64.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libgeneral"

  def fix_tihmstar
    if File.symlink?("COPYING")
      rm "COPYING"
      touch "LICENSE"
      cp "LICENSE", "COPYING"
    end

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
