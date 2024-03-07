class LibtihmstarGeneral < Formula
  desc "General stuff for tihmstar's projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral.git",
    revision: "017d71edb0a12ff4fa01a39d12cd297d8b3d8d34"
  version "63"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/img4tool.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "60fd57a3f45f5dfb2c50ab91bce96559221f0aa5f3c207ed1e443065cbe57f0a"
    sha256 cellar: :any, big_sur:  "a38e775d660531e528093d0556247b5c673eb763a02c7ef1aeb7c90509da863c"
    sha256 cellar: :any, catalina: "1c1fb4a3e9822881962a743e61b0023998cb566823ddaf89b7c31c4d6756026f"
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
