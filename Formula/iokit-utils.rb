class IokitUtils < Formula
  desc "Little dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils/archive/1.4.0.tar.gz"
  sha256 "076731d902717cf60a9c8b1b2a176a0ee0caf96354219f509bdd8675200231c4"
  license "MPL-2.0-no-copyleft-exception"
  head "https://github.com/Siguza/iokit-utils.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    sha256 cellar: :any_skip_relocation, monterey: "63e1be4ea72390d6be7256369cefea5289adc6b5fb6e911ff587cae8c1794252"
    sha256 cellar: :any_skip_relocation, big_sur:  "2a7ac460589924a30202522562371e0ec139fb96b3e2907f3efe6884cc0003e7"
    sha256 cellar: :any_skip_relocation, catalina: "a2274b27d1882729966b7af4f3154ecc92c57b115b7492429c893efa4cf6b96f"
  end

  def install
    bindir = "bin/macos"
    binaries = %w[
      ioclass
      ioprint
      ioscan
    ]
    # disable codesigning
    inreplace "Makefile",
      "codesign", "true",
      true
    binaries.each do |b|
      system "make", "#{bindir}/#{b}"
      bin.install "#{bindir}/#{b}"
    end
  end

  test do
    assert_equal "__kernel__\n",
      shell_output("#{bin}/ioclass -b RootDomainUserClient")
  end
end
