class Libimobiledevice < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://github.com/libimobiledevice/libimobiledevice"
  url "https://github.com/libimobiledevice/libimobiledevice.git",
    revision: "93c25b7846179c397a5316fb4fecb31ceff0ec2f"
  version "1.3.0-158-g93c25b7"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libimobiledevice.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
  depends_on "libtasn1"
  depends_on "openssl@1.1"
  depends_on "stek29/idevice/libplist"
  depends_on "stek29/idevice/libusbmuxd"

  def install
    system "./autogen.sh",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      "--without-cython"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "idevicedate #{version}\n", shell_output("#{bin}/idevicedate -v")
  end
end
