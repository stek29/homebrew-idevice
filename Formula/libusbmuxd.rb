class Libusbmuxd < Formula
  desc "Library to handle usbmux protocol connections with iOS devices"
  homepage "https://github.com/libimobiledevice/libusbmuxd"
  url "https://github.com/libimobiledevice/libusbmuxd.git",
    revision: "07cd6f774fd444f981ade6e75e10962ba0439350"
  version "2.0.2-34-g07cd6f7"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libusbmuxd.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "5b5d7a7c9c99f82a5d150913138f9c67179672c51b2d698241d8bd5879270f20"
    sha256 cellar: :any, big_sur:  "2c7694242cacde59ed64607a3a609d9066f4a1f8b4c64945953ebc8725dcb0d2"
    sha256 cellar: :any, catalina: "41c058154a32e154940c5677611cccb9e72d6df7482cb99721f3e61ca00e3f22"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libusb"
  depends_on "stek29/idevice/libimobiledevice-glue"

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
