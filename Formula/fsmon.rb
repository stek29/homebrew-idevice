class Fsmon < Formula
  desc "FileSystem events Monitor"
  homepage "https://github.com/nowsecure/fsmon.git"
  url "https://github.com/nowsecure/fsmon/archive/1.8.5.tar.gz"
  sha256 "eb99cfb242bea9fc5bde66e67f4324bd71100d17b1672e4e52db14b9a5e2900a"

  def install
    system "make", "osx"
    mv "fsmon-osx", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
