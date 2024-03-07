class Libirecovery < Formula
  desc "Library for communication with iBoot/iBSS of iOS devices via USB"
  homepage "https://github.com/libimobiledevice/libirecovery"
  url "https://github.com/libimobiledevice/libirecovery.git",
    revision: "447ae096e4debbcfe63a875154074159cbd551e0"
  version "1.1.0-25-g447ae09"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libirecovery.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libirecovery-1.1.0-25-g447ae09"
    sha256 cellar: :any, arm64_sonoma: "3a3b9c1c585ab8fd269768d317559d486c0f0fb34fc94e885f4ee4a55f51f038"
    sha256 cellar: :any, ventura:      "839aa7ff745790403e66f3ac5d114480d07d9ae25b4c6bead9bfc8571de9e82c"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
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
    assert_equal "irecovery #{version}\n", shell_output("#{bin}/irecovery -V")
  end
end
