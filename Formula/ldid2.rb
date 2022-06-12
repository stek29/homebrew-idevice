class Ldid2 < Formula
  desc "Unofficial ldid fork which handles sha256 signatures"
  homepage "https://github.com/xerub/ldid"

  url "https://github.com/xerub/ldid.git",
    revision: "db74fea4424ddf8b217a0a8f98bcdc0d8ff29908"
  version "42-3-gdb74fea"
  license "AGPL-3.0-or-later"
  head "https://github.com/xerub/ldid.git"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "610074df54c12ccbea374e4e21c3493c30f5de5f9921b2b8e8aebf0662887d7c"
    sha256 cellar: :any_skip_relocation, big_sur:  "1f35dfd048633859e193456667c6803aefb1de912be4119e64d399e4be830a52"
    sha256 cellar: :any_skip_relocation, catalina: "09fb4bf2fbc3b42a090cd6913669f468c70e0b02377cab15efcc92cd87a35f35"
  end

  depends_on "openssl@1.1"

  def install
    system ENV.cc, "-I.", "sha224-256.c", "ldid2.cpp", "lookup2.c", "-lc++", "-oldid2"
    bin.install "ldid2"
  end

  test do
    (testpath/"test.c").write <<~EOS
      int main(int argc, char **argv) { return 0; }
    EOS

    system ENV.cc, "test.c", "-o", "test"
    system "#{bin}/ldid2", "-S", "test"
  end
end
