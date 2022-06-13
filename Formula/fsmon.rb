class Fsmon < Formula
  desc "FileSystem events monitor"
  homepage "https://github.com/nowsecure/fsmon"
  url "https://github.com/nowsecure/fsmon/archive/1.8.5.tar.gz"
  sha256 "eb99cfb242bea9fc5bde66e67f4324bd71100d17b1672e4e52db14b9a5e2900a"
  license "MIT"
  head "https://github.com/nowsecure/fsmon.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "d079dbdf4f4c66e143a2ed736e2bc0333dfa2f14e1cff4fbd2db37784ecb09f7"
    sha256 cellar: :any_skip_relocation, big_sur:  "30e4c0964f1eeb268cc7c0339650880dbae62f3a199852df6ae5afb92fbf9afc"
    sha256 cellar: :any_skip_relocation, catalina: "ac6ddf44462b2cd33c6b2927a5b2cd998a1e543427e3b3f81e6834d5370f64e2"
  end

  def install
    system "make", "macos"
    mv "fsmon-macos", "fsmon"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "fsmon #{version}\n", shell_output("#{bin}/fsmon -v")
  end
end
