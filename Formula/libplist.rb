class Libplist < Formula
  desc "Library to handle Apple Property List files in binary or XML format"
  homepage "https://github.com/libimobiledevice/libplist"
  url "https://github.com/libimobiledevice/libplist.git",
    revision: "db93bae96d64140230ad050061632531644c46ad"
  version "2.2.0-92-gdb93bae"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "140659740d090194e521c28d80d43a3e2383f68b79c1fc7e35ee7b9a915d3cbb"
    sha256 cellar: :any, big_sur:  "20152f292c78a3fe97c626d5ba0f7582094329f2d64d87ab5d5bdf3b1d8146f7"
    sha256 cellar: :any, catalina: "b63dab4860034a09fc2442afc0988e552750df41eb9858619e63cceb09a20338"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --without-cython
    ]

    system "./autogen.sh", *args
    system "make"
    system "make", "install", "PYTHON_LDFLAGS=-undefined dynamic_lookup"
  end

  test do
    (testpath/"test.plist").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Key</key>
        <string>Value</string>
      </dict>
      </plist>
    EOS
    assert_equal '{"Key":"Value"}', shell_output("#{bin}/plistutil -i test.plist -f json")
  end
end
