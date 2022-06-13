class Tsschecker < Formula
  desc "Tool to check TSS signing status of various devices"
  homepage "https://github.com/1Conan/tsschecker"
  url "https://github.com/1Conan/tsschecker.git",
    revision: "ba70a6ad0c818b67028276c430ef221591692d2a"
  version "382"
  license "LGPL-3.0-or-later"
  head "https://github.com/1Conan/tsschecker.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "90ac85869eb6e363dcb97e31c2f11b8018978eb0136cf6e021c5c62bc901483e"
    sha256 cellar: :any, big_sur:  "33d9a272e5dd25a5cc320b646994382b443a39d9813503365665ab7fc4df187f"
    sha256 cellar: :any, catalina: "77d498dbd047ff4b8288683b415ec4aee080f22066e8113ad15bb6256d9f1113"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "stek29/idevice/libirecovery"
  depends_on "stek29/idevice/libplist"

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

    # we dont need libjssy
    bin.install "tsschecker/tsschecker" => "tsschecker"
  end

  def caveats
    <<~EOS
      this is not the "official" tihmstar/tsschecker, but a maintained fork by 1Conan
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tsschecker", 255)
      .split("\n")
      .first.match(/version: 0\.(\d+)-/).captures.first
  end
end
