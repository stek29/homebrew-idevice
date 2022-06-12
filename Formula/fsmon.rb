class Fsmon < Formula
  desc "FileSystem events Monitor"
  homepage "https://github.com/nowsecure/fsmon"
  url "https://github.com/nowsecure/fsmon/archive/1.8.5.tar.gz"
  sha256 "eb99cfb242bea9fc5bde66e67f4324bd71100d17b1672e4e52db14b9a5e2900a"

  def install
    system "make", "macos"
    mv "fsmon-macos", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "fsmon #{version}\n", shell_output("#{bin}/fsmon -v")
  end
end
