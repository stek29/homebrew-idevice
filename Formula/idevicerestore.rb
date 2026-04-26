class Idevicerestore < Formula
  desc "Restore firmware files to iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/idevicerestore.git",
    revision: "8a5abb99170b324b0fc5a00928ba2ac78a7afc98"
  version "1.0.0-171-g8a5abb9"
  license "LGPL-3.0-or-later"
  head "https://github.com/libimobiledevice/idevicerestore.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/idevicerestore-1.0.0-171-g8a5abb9"
    sha256 cellar: :any, arm64_sonoma: "0ad011810694656c4cd8dd76a0121140702478952252aaead1b6629e98329b5c"
    sha256 cellar: :any, ventura:      "3aedf536d97b40aae1aac22d0900f706eac8e93eaeea05598ba9456a7a34f462"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "libtatsu"
  depends_on "libzip"
  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libirecovery"

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
    assert_equal "idevicerestore #{version}\n", shell_output("#{bin}/idevicerestore -v")
  end
end
