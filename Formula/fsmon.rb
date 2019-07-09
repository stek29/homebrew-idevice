class Fsmon < Formula
  desc "FileSystem events Monitor"
  homepage "https://github.com/nowsecure/fsmon"
  url "https://github.com/nowsecure/fsmon/archive/1.6.1.tar.gz"
  sha256 "79b6b0c256ac2464cb02f0e36566cda66bf9cbb5dd4005290beb89ee815d2067"

  def install
    system "make", "osx"
    mv "fsmon-osx", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
