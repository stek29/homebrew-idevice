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
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libimobiledevice-1.3.0-210-g73b6fd1"
    sha256 cellar: :any, arm64_sonoma: "6d953628da0d7f806bcf5eba9682a17e6ebc87ae08ac08d0f5801759a4e95620"
    sha256 cellar: :any, ventura:      "b4f790c84f3c435abad7b9ada2373a7a6f47e30dc12b9215293b90dea7cfcbf2"
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
