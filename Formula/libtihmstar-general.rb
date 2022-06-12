class LibtihmstarGeneral < Formula
  desc "General stuff for tihmstar's projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral.git",
    revision: "017d71edb0a12ff4fa01a39d12cd297d8b3d8d34"
  version "63"
  head "https://github.com/tihmstar/img4tool.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  keg_only "its an utility library for tihmstar's projects and shouldnt be used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
