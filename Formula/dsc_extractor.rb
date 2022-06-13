class DscExtractor < Formula
  desc "Extract dyld shared cache into individual libraries and frameworks"
  homepage "https://opensource.apple.com/tarballs/dyld/"
  url "https://opensource.apple.com/tarballs/dyld/dyld-852.2.tar.gz"
  sha256 "f38e62fa9d3aec0bbc487cc27bf141b060e163195878c2dde31cb54609e436c4"
  revision 1

  livecheck do
    url :homepage
    strategy :page_match
    regex(/a href=dyld-([\d.]+)\.t/im)
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    sha256 cellar: :any_skip_relocation, monterey: "1ec338b250a2436ba4b984e774914435fa47cb525723e0178ae6ed9e95f91c7a"
    sha256 cellar: :any_skip_relocation, big_sur:  "25e3fc186ebc1192cd2a4ea1b4a8765e38f11de027a4d004dd7693641f00e343"
    sha256 cellar: :any_skip_relocation, catalina: "bf9f3883d6c662df2686ceb041460c893bc79ef71400ab0730c3dc211170fa01"
  end

  def install
    src = "dyld3/shared-cache/dsc_extractor.cpp"
    inreplace src do |s|
      s.gsub!(/.*\n#if 0/m, "#if 1")
      s.gsub! %r{(dlopen\(").*/(dsc_extractor.bundle)}, '\1\2'
    end

    system ENV.cxx.to_s, "-o", "dsc_extractor", src
    bin.install "dsc_extractor"
  end

  def caveats
    <<~EOS
      dsc_extractor is just a cli wrapper around dsc_extractor.bundle,
      which is provided by Xcode

      because of that Xcode needs to be installed for dsc_extractor to work
    EOS
  end

  test do
    assert_equal "usage: dsc_extractor <path-to-cache-file> <path-to-device-dir>\n",
      shell_output("#{bin}/dsc_extractor 2>&1", 1)
  end
end
