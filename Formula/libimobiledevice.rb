class Libimobiledevice < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://github.com/libimobiledevice/libimobiledevice"
  url "https://github.com/libimobiledevice/libimobiledevice.git",
    revision: "73b6fd183872096f20e6d1007429546a317a7cb1"
  version "1.3.0-210-g73b6fd1"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libimobiledevice.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "7da19d95a57bb0cab25a791a561f07fd2e03b657114089add2e8f29f2bd11307"
    sha256 cellar: :any, big_sur:  "0bd130bd38a83df2b47bd2cf6b194a9eace6c85692df297e7770f2be8035b28d"
    sha256 cellar: :any, catalina: "408744b6dbb80fc7dd000c8a231205967407554189b075cd41139fd9b4680de1"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libtasn1"
  depends_on "openssl@1.1"
  depends_on "stek29/idevice/libimobiledevice-glue"
  depends_on "stek29/idevice/libusbmuxd"

  def install
    args = %w[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --without-cython
    ]

    system "./autogen.sh", *std_configure_args, *args

    system "make"
    system "make", "install"
  end

  test do
    assert_equal "idevicedate #{version}\n", shell_output("#{bin}/idevicedate -v")
  end
end
