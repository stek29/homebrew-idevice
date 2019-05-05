class Img4tool < Formula
  desc "Tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  url "https://github.com/tihmstar/img4tool.git",
    :revision => "1bffa0e699602b4926e3a2d15e5217fba3ecb6f5"
  version "118"
  head "https://github.com/tihmstar/img4tool.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "openssl"

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
    bin.install "img4tool/img4tool"
  end
end
