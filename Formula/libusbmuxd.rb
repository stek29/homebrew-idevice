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
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libusbmuxd-2.0.2-34-g07cd6f7"
    sha256 cellar: :any, arm64_sonoma: "94cfcb6fecdbd8f4fd000118e44f930bc1ef0ad15160afd163b070f7644035f4"
    sha256 cellar: :any, ventura:      "5869bfcc157d4934ce601ab98a262f2de5dd31c59598c503f1570e39117be07b"
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
