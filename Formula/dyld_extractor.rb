class DyldExtractor < Formula
  desc "Extract dyld shared cache into individual libraries and frameworks"
  homepage "https://opensource.apple.com/source/dyld/"
  url "https://opensource.apple.com/tarballs/dyld/dyld-733.6.tar.gz"
  sha256 "cabbea38a188a3b3c57e3f5ecba2d0124aa5c1edc4676d814ac635410bf1c538"

  depends_on :xcode

  def install
    system "grep \"// test\" -A 34 launch-cache/dsc_extractor.cpp > extract.cpp"
    system "clang++ -o dsc_extractor extract.cpp"
    bin.install "dsc_extractor"
  end

end
