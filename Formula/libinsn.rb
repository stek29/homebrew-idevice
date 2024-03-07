class Libinsn < Formula
  desc "Instruction decoder/encoder for 64bit ARM"
  homepage "https://github.com/tihmstar/libinsn"
  url "https://github.com/tihmstar/libinsn.git",
    revision: "c2ed667df12e185b0964cf32850f8e42839ccaa9"
  version "49"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/libinsn.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libinsn-49"
    sha256 cellar: :any, arm64_sonoma: "3570efb30d0b83949b612cdf1d0e018e578a2cc53a87cbcfa8f4da9bbb202a06"
    sha256 cellar: :any, ventura:      "75972e615d4581011bf349387414c98147e106b316de96aef46bb05a17204386"
  end

  keg_only "its an utility library for tihmstar's projects and shouldnt be used by anything else"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libtihmstar-general"

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", *std_configure_args
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "true"
  end
end
