class Libimobiledevice < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://github.com/libimobiledevice/libimobiledevice"
  url "https://github.com/libimobiledevice/libimobiledevice.git",
    revision: "73b6fd183872096f20e6d1007429546a317a7cb1"
  version "1.3.0-210-g73b6fd1"
  license "LGPL-2.1-or-later"
  revision 1
  head "https://github.com/libimobiledevice/libimobiledevice.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libimobiledevice-1.3.0-210-g73b6fd1_1"
    sha256 cellar: :any, arm64_sonoma: "2f076e42163e6a39d3a616167bb4994136c29c4fe606c38c909a2129af849b24"
    sha256 cellar: :any, ventura:      "1886597144b7d35d4a9cd07fe1de6c3e56e4b30c9d7613b7d9af188d33450284"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue"
  depends_on "libplist"
  depends_on "libtasn1"
  depends_on "libtatsu"
  depends_on "openssl@3"
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
