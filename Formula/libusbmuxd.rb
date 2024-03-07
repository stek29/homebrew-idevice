class Libusbmuxd < Formula
  desc "Library to handle usbmux protocol connections with iOS devices"
  homepage "https://github.com/libimobiledevice/libusbmuxd"
  url "https://github.com/libimobiledevice/libusbmuxd.git",
    revision: "07cd6f774fd444f981ade6e75e10962ba0439350"
  version "2.0.2-34-g07cd6f7"
  license "LGPL-2.1-or-later"
  revision 1
  head "https://github.com/libimobiledevice/libusbmuxd.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libusbmuxd-2.0.2-34-g07cd6f7_1"
    sha256 cellar: :any, arm64_sonoma: "1301a8f88b3953d64f535856062a3d851e4d07f44f6fee24c414946213f01d3d"
    sha256 cellar: :any, ventura:      "5fd66f5a3e781ae61e745765c4e8d25458d0b31ea6f6569656bfd3dd9f4583f8"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
  depends_on "libplist"
  depends_on "libusb"

  def install
    args = %w[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./autogen.sh", *std_configure_args, *args

    system "make"
    system "make", "install"
  end

  test do
    assert_equal "iproxy #{version}\n", shell_output("#{bin}/iproxy -v")
  end
end
