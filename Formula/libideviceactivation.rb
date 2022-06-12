class Libideviceactivation < Formula
  desc "Library to handle the activation process of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/libideviceactivation.git",
    revision: "75505b75816691e1ff651fb55bfc6aaa7170ba3f"

  # it's actually 1.1.1-12-g75505b7 if using git describe
  # but 1.1.2 is hardcoded in libideviceactivation, unlike other libimobiledevice
  # projects, which use git describe based versioning
  # so 1.1.2 is from hardcoded version, and second part is from git describe
  version "1.1.2-12-g75505b7"

  license "LGPL-3.0-or-later"
  head "https://github.com/libimobiledevice/libideviceactivation.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    sha256 cellar: :any, monterey: "fd1a033a79496ed0138842677f43426f62c8682dd97afe119d7442c59f56ce2c"
    sha256 cellar: :any, big_sur:  "ce9c3c845db53537898e39c7d9f6f35d25b23ea261d1db9ec310929f26079117"
    sha256 cellar: :any, catalina: "1adfa279c6124778c6d9594b87c4a9a8067b5306328cfbb6a5476842672ceb66"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libplist"
  depends_on "stek29/idevice/libusbmuxd"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "ideviceactivation #{version.to_s.split("-").first}\n", shell_output("#{bin}/ideviceactivation -v")
  end
end
