class Libtatsu < Formula
  desc "Library handling the communication with Apple's Tatsu Signing Server (TSS)"
  homepage "https://github.com/libimobiledevice/libtatsu"
  url "https://github.com/libimobiledevice/libtatsu/releases/download/1.0.4/libtatsu-1.0.4.tar.bz2"
  sha256 "08094e58364858360e1743648581d9bad055ba3b06e398c660e481ebe0ae20b3"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libtatsu.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "it can conflict with homebrew/core"

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

    system "./configure", *std_configure_args, *args

    system "make"
    system "make", "install"
  end
end
