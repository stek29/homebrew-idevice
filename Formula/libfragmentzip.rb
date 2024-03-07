class Libfragmentzip < Formula
  desc "Library for downloading single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip.git",
    revision: "aaf6fae83a0aa6f7aae1c94721857076d04a14e8"
  version "64"
  license "LGPL-3.0-or-later"
  head "https://github.com/tihmstar/libfragmentzip.git", branch: "master"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{(\d+) Commits}im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "7edf7681ecc2b0181cede6640517c5c85a55ed90bdc3b1313bdfb895cf3d61e1"
    sha256 cellar: :any, big_sur:  "3345b18573cc36116bac45e503fbc06711b675da9db610dd5accf9c6ac86b32c"
    sha256 cellar: :any, catalina: "cb9f8d611c6726d009e546658edf936a266b03270ef63587b30f497b72d1f364"
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

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
