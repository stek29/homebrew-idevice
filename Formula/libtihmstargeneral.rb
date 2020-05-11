class Libtihmstargeneral < Formula
  desc "General general stuff for tihmstar's projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral.git",
    :tag => "31"
  head "https://github.com/tihmstar/img4tool.git"

  keg_only "its an utility library for tihmstar's projects and shouldnt be used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def fix_tihmstar
    inreplace %w[configure.ac],
      "$(git rev-list --count HEAD)",
      version.to_s.gsub(/[^\d]/, ""),
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
