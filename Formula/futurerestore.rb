class Futurerestore < Formula
  desc "Hacked up idevicerestore wrapper"
  disable! date: "2022-06-11", because: "cant be built - see https://github.com/stek29/homebrew-idevice/issues/23"
  homepage "https://github.com/futurerestore/futurerestore"
  url "https://github.com/futurerestore/futurerestore.git",
    revision: "f7fa07e2bae25b333f2365b06c23a461ed022a5a"
  version "279"

  head "https://github.com/futurerestore/futurerestore.git"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
  end

  option "without-libipatcher", "Don't bundle libipatcher; disables Odysseus support"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  depends_on "img4tool"
  depends_on "libfragmentzip"
  depends_on "libzip"

  depends_on "tsschecker"
  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libirecovery"
  depends_on "stek29/idevice/libplist"

  def install
    ENV["ARCH"] = "x86_64"
    system "cmake", ".", *std_cmake_args
    system "make", "install"

    # we don't need libjssy.a
    bin.install "src/futurerestore" => "futurerestore"
  end
end
