class Libinsn < Formula
  desc "Instruction decoder/encoder for 64bit ARM"
  homepage "https://github.com/tihmstar/libinsn"
  url "https://github.com/tihmstar/libinsn.git",
    revision: "e795956b0c0e0c2fcbb074ee1f1cfd84e98f0918"
  version "37"
  license "LGPL-2.1-or-later"
  head "https://github.com/tihmstar/libinsn.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "48620732f72dbe2fa8592b6ff36e2c1f3d1946ca64af0b260713fbfdf0f95c45"
    sha256 cellar: :any, big_sur:  "f209e117921ff8b011774823cb37c8fc189bbceb13f46f3ca97494eb7b2c9c4f"
    sha256 cellar: :any, catalina: "c4a43eb1c4cef94c5a47b739059a28df9296b8e12b9bd098451f09b779cb4913"
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

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "true"
  end
end
