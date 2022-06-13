class Libirecovery < Formula
  desc "Library for communication with iBoot/iBSS of iOS devices via USB"
  homepage "https://github.com/libimobiledevice/libirecovery"
  url "https://github.com/libimobiledevice/libirecovery.git",
    revision: "17c02beca2f99b27dab5c1f83cfe4e33036e462b"
  version "1.0.1-46-g17c02be"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libirecovery.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "bd24639530e333093b710a23864abeff5aa425690d4e5f6c2f4f4593e0cc17ab"
    sha256 cellar: :any, big_sur:  "8b761c648eb1b0b738b4f9686b2e24542dc1ee87c0fd9540bc258e9ed4c950a0"
    sha256 cellar: :any, catalina: "20cb02a9f6b296a04e6465bf1f17461e19366615b82cf1974ce4c654961dbf95"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
  depends_on "libusb"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "irecovery #{version.to_s.split("-").first}\n", shell_output("#{bin}/irecovery -V")
  end
end
