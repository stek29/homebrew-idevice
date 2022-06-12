class Libplist < Formula
  desc "Library to handle Apple Property List files in binary or XML format"
  homepage "https://github.com/libimobiledevice/libplist"
  url "https://github.com/libimobiledevice/libplist.git",
    revision: "db93bae96d64140230ad050061632531644c46ad"
  version "2.2.0-92-gdb93bae"
  license "LGPL-2.1-or-later"
  head "https://github.com/libimobiledevice/libplist.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 2
    sha256 cellar: :any, monterey: "2dc619d957a838ebe38baf8e83c9e6130dcfbca33942829292bad41ea72e1766"
    sha256 cellar: :any, big_sur:  "8dd91eb109d5138f0804c6895efa45fa76ef151865d476b83e28000d58697fd9"
    sha256 cellar: :any, catalina: "2e094fc4d26f4675666bb7074076efb87677cefaf205996442f4956cea00c707"
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
