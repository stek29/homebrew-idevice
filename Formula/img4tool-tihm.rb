class Img4toolTihm < Formula
  desc "Tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  url "https://github.com/tihmstar/img4tool.git",
    :revision => "6e166ceb888f601cc254a4f817a3e7e02b12ac5a"
  version "109"
  head "https://github.com/tihmstar/img4tool.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "openssl"

  def fix_tihmstar
    mkdir_p "m4"

    if File.symlink?("COPYING")
      rm "COPYING"
      if File.exist?("LICENSE")
        cp "LICENSE", "COPYING"
      else
        touch "COPYING"
      end
    end

    vers = version.to_s.sub /[^\d]/, ""
    inreplace(File.exist?("setBuildVersion.sh") ? "setBuildVersion.sh" : "autogen.sh", "$(git rev-list --count HEAD)", vers)
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
