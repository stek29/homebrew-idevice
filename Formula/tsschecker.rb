class Tsschecker < Formula
  desc "Tool to check tss signing status of various devices"
  homepage "https://github.com/tihmstar/tsschecker"
  url "https://github.com/tihmstar/tsschecker.git",
    :revision => "4339d71fb0ebb671aeda9061979dd5e7ab87f3d3"
  version "263"

  head "https://github.com/tihmstar/tsschecker.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libfragmentzip"
  depends_on "libirecovery"
  depends_on "libplist"

  def fix_tihmstar
    if File.symlink?("COPYING")
      rm "COPYING"
      touch "LICENSE"
      cp "LICENSE", "COPYING"
    end

    files = %w[setBuildVersion.sh autogen.sh configure.ac]
    inreplace files.select { |f| File.exist? f },
      "$(git rev-list --count HEAD)",
      version.to_s.gsub(/[^\d]/, ""),
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    # No, thanks, we dont need libjssy
    # system "make", "install"
    # rm_rf "#{lib}/libjssy.a"
    bin.install "tsschecker/tsschecker" => "tsschecker"
  end
end
