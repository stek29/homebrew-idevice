class LibtihmstarGeneral < Formula
  desc "General stuff for tihmstar's projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral.git",
    revision: "6bca5824f23ab88af0de6568bc7b3213318c27ed"
  version "77"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/libgeneral.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libtihmstar-general-77"
    sha256 cellar: :any, arm64_sonoma: "8fb71f18058442679e0623e40ec9bae2ea21da7ef86624d0e18228ca0116b6b8"
    sha256 cellar: :any, ventura:      "f598b2159ba5aa15c4023717d9cf0e5cf43c9dcfc47e4f7ea8c3ff38af63b205"
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

    system "./autogen.sh", *std_configure_args
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
