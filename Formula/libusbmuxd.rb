class Libusbmuxd < Formula
  desc "Library to handle usbmux protocol connections with iOS devices"
  homepage "https://github.com/libimobiledevice/libusbmuxd"
  url "https://github.com/libimobiledevice/libusbmuxd.git",
    revision: "36ffb7ab6e2a7e33bd1b56398a88895b7b8c615a"
  version "2.0.2-24-g36ffb7a"
  head "https://github.com/libimobiledevice/libusbmuxd.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "to avoid conflicts with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
  depends_on "libusb"
  depends_on "stek29/idevice/libplist"

  def install
    system "./autogen.sh",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "iproxy #{version}\n", shell_output("#{bin}/iproxy -v")
  end
end
