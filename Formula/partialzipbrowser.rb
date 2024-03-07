class Partialzipbrowser < Formula
  desc "Tool for zip files on remote webserver"
  homepage "https://github.com/tihmstar/partialZipBrowser"
  url "https://github.com/tihmstar/partialZipBrowser.git",
    revision: "9bfdde2b2456181045f74631683fba491d8bf4f2"
  version "38"
  license "LGPL-3.0-or-later"
  head "https://github.com/tihmstar/partialZipBrowser.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{(\d+) Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "6832d6da9fb54db8037a869e6e814fc5c240eb94292b2d25fce2307b8a055a89"
    sha256 cellar: :any, big_sur:  "37e508636f240f8d33ee8389aa62ec5fa6b2c70ca51ac5dca88f823863aceb0a"
    sha256 cellar: :any, catalina: "5220440d9d71fc637e1bf95fa0a3f175791163d1d9dd05b5e34da28771518441"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libtihmstar-general"

  uses_from_macos "zip" => :test

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
    system "make", "install"
  end

  test do
    test_data = <<~EOS
      this is a test file
      zipped and unzipped!
    EOS
    (testpath/"test.txt").write test_data
    system "zip", "test.zip", "test.txt"
    assert_equal test_data, shell_output("#{bin}/pzb -g test.txt -o - file://./test.zip", 1)
  end
end
