class Ldid2 < Formula
  desc "Unofficial ldid fork which handles sha256 signatures"
  homepage "https://github.com/xerub/ldid"

  url "https://github.com/xerub/ldid.git",
    :revision => "db74fea4424ddf8b217a0a8f98bcdc0d8ff29908"
  version "42-3-gdb74fea"

  livecheck do
    skip "upstream has inconsistent tags"
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
    system bin/"ldid2", "-S", "test"
  end
end
