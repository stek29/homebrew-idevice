class Img4tool < Formula
  desc "Tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  url "https://github.com/tihmstar/img4tool.git",
    revision: "e1c37d6ce8c629ca9669efc9cb5b5f7d6810ed30"
  version "202"
  license "LGPL-3.0-or-later"
  head "https://github.com/tihmstar/img4tool.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "7b6fdeb7d4c2d483e3d44f8868ac11c6c1124acc12719e93ae9d4956f941db50"
    sha256 cellar: :any, big_sur:  "0a2b86b948b180f4369c0df46917448021c777e06bb3c3059c113ffe898f1158"
    sha256 cellar: :any, catalina: "c6db68f6e8fe662600d32428234bfde65d0bd16060952560d47e8e95fa206b91"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libtihmstar-general"
  depends_on "openssl@3"

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
    assert_equal version.to_s, shell_output("#{bin}/img4tool", 254)
      .split("\n")
      .first.match(/version: 0\.(\d+)-/).captures.first
  end
end
