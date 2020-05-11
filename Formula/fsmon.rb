class Fsmon < Formula
  desc "FileSystem events Monitor"
  homepage "https://github.com/nowsecure/fsmon"
  url "https://github.com/nowsecure/fsmon/archive/1.7.0.tar.gz"
  sha256 "b2bb279d50db4103450a1c755d0581116884bacccce1b7a9deef2de0f418fffd"

  def install
    system "make", "osx"
    mv "fsmon-osx", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end
end
