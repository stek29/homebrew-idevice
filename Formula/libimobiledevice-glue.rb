class LibimobiledeviceGlue < Formula
  desc "Library with common code used by the libimobiledevice project"
  homepage "https://github.com/libimobiledevice/libimobiledevice-glue"
  url "https://github.com/libimobiledevice/libimobiledevice-glue.git",
    revision: "d2ff7969dcd0a12e4f18f63dab03e6cd03054fcb"
  version "1.0.0-35-gd2ff796"
  head "https://github.com/libimobiledevice/libimobiledevice-glue.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "its an utility library for libimobiledevice"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "libplist"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "true"
  end
end
