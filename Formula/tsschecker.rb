class Tsschecker < Formula
  desc "Tool to check tss signing status of various devices"
  homepage "https://github.com/tihmstar/tsschecker"
  url "https://github.com/tihmstar/tsschecker.git",
    revision: "59554beb8e79319e12d8f373fd5bb9846b8c69c9"
  version "323"

  head "https://github.com/tihmstar/tsschecker.git"

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
  depends_on "libplist"
  depends_on "stek29/idevice/libirecovery"

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
    v = shell_output("#{bin}/tsschecker", 255).split("\n").first.split("-").last.strip
    assert_equal version.to_s, v
  end
end
