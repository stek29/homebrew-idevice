class Fsmon < Formula
  desc "FileSystem events Monitor"
  homepage "https://github.com/nowsecure/fsmon"
  url "https://github.com/nowsecure/fsmon/archive/1.6.1.tar.gz"
  sha256 "37ea1c83297976f5c7058637a328150dea57743d5eb55ebfc3a8075d262d67c2"

  def install
    system "make", "osx"
    mv "fsmon-osx", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
