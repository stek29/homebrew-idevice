class DscExtractor < Formula
  desc "Extract dyld shared cache into individual libraries and frameworks"
  homepage "https://opensource.apple.com/tarballs/dyld/"
  url "https://opensource.apple.com/tarballs/dyld/dyld-852.2.tar.gz"
  sha256 "f38e62fa9d3aec0bbc487cc27bf141b060e163195878c2dde31cb54609e436c4"

  depends_on :xcode

  livecheck do
    url :homepage
    strategy :page_match
    regex(/a href=dyld-([\d.]+).tar.gz/m)
  end

  def install
    src = "dyld3/shared-cache/dsc_extractor.cpp"
    inreplace src,
      %r{.*\n#if 0}m,
      "#if 1"
    system "#{ENV.cc}", "-o", "dsc_extractor", src
    bin.install "dsc_extractor"
  end
end
