class Tsschecker < Formula
  desc "Tool to check TSS signing status of various devices"
  homepage "https://github.com/1Conan/tsschecker"
  url "https://github.com/1Conan/tsschecker.git",
    revision: "ba70a6ad0c818b67028276c430ef221591692d2a"
  version "382"

  head "https://github.com/1Conan/tsschecker.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
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

  test do
    assert_equal version.to_s, shell_output("#{bin}/tsschecker", 255)
      .split("\n")
      .first.match(/version: 0\.(\d+)-/).captures.first
  end
end
