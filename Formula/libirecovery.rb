class Libirecovery < Formula
  desc "Library for communication with iBoot/iBSS of iOS devices via USB"
  homepage "https://github.com/libimobiledevice/libirecovery"
  url "https://github.com/libimobiledevice/libirecovery.git",
    revision: "17c02beca2f99b27dab5c1f83cfe4e33036e462b"
  version "1.0.1-46-g17c02be"

  livecheck do
    skip "upstream has inconsistent tags"
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
