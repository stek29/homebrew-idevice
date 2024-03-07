class Libfragmentzip < Formula
  desc "Library for downloading single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git",
    revision: "2dcd708f838eb2eb7adea1f07a3350a0f9e08faa"
  version "70"
  license "LGPL-3.0-or-later"
  head "https://github.com/tihmstar/libfragmentzip.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(/(\d+) Commits/im)
  end

  bottle do
    root_url "https://github.com/stek29/homebrew-idevice/releases/download/libfragmentzip-70"
    sha256 cellar: :any, arm64_sonoma: "584b2f0064be28ea5b660ecc05a4011008c318c85d731e15585c13801eb159d8"
    sha256 cellar: :any, ventura:      "7cfbcd546727c873357691e6fdb64be0c00188e6d1d03881671c9dd58b000d00"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libtihmstar-general"
  depends_on "libzip"

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", *std_configure_args
    system "make"
    system "make", "install"
  end
end
