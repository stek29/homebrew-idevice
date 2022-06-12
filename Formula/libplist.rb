class Libplist < Formula
  desc "Library to handle Apple Property List files in binary or XML format"
  homepage "https://github.com/libimobiledevice/libplist"
  url "https://github.com/libimobiledevice/libplist.git",
    revision: "db93bae96d64140230ad050061632531644c46ad"
  version "2.2.0-92-gdb93bae"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "to avoid conflicts with homebrew/core"

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
