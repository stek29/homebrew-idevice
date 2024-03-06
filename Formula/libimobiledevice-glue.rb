class LibimobiledeviceGlue < Formula
  desc "Common code used by the libimobiledevice project"
  homepage "https://github.com/libimobiledevice/libimobiledevice-glue"
  url "https://github.com/libimobiledevice/libimobiledevice-glue/releases/download/1.1.0/libimobiledevice-glue-1.1.0.tar.bz2"
  sha256 "e7f93c1e6ceacf617ed78bdca92749d15a9dac72443ccb62eb59e4d606d87737"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libimobiledevice-glue.git", branch: "master"

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libimobiledevice-glue-1.1.0"
    sha256 cellar: :any, arm64_sonoma: "454bec6a4d818189f94e9337be2d3f608f4a9d247ef0f8f1168698f8a6f4a22c"
    sha256 cellar: :any, ventura:      "a3297ac61fd6dd23ce219df8260482a654950a15c2f09295f7523c719542a57e"
  end

  keg_only "it's an utility library for libimobiledevice"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"

  def install
    args = %w[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./autogen.sh", *std_configure_args, *args if build.head?
    system "./configure", *std_configure_args, *args if build.stable?

    system "make"
    system "make", "install"
  end
end
