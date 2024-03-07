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
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/img4tool-202"
    sha256 cellar: :any, arm64_sonoma: "ef79e4979aa8837f5068cd9ffa6ceada2fa512f2cf143b16416ef6ac55223b7e"
    sha256 cellar: :any, ventura:      "8a1d65d8de596044094bc3d8af24ecf7beff12d07c52f8c565e494ac16e70450"
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
