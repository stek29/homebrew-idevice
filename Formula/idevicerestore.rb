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
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "205ebc83b811335dcfdf8e1b3ddc20a810b42ff55942738befe237e16871edcf"
    sha256 cellar: :any, big_sur:  "f89e42bc4f6cd319370dfe49920b56cff5fb5a8e69bbca317946380c228f3c46"
    sha256 cellar: :any, catalina: "dd0ae78fac58abaf28bca3b517dbf06f8827c2e728dc5cdc9ed2a498ef4ed158"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
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
