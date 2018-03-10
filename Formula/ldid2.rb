class Ldid2 < Formula
  desc "Unofficial ldid fork which handles sha256 signatures"
  homepage "https://github.com/xerub/ldid"

  url "https://github.com/xerub/ldid.git"
  head "https://github.com/xerub/ldid.git"

  version "2.0"

  depends_on "openssl"

  def install
    system ENV.cc, *%W[-I. sha224-256.c ldid2.cpp lookup2.c -lc++ -o ldid2]
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
