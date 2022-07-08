class IokitUtils < Formula
  desc "Little dev tools for probing IOKit"
  homepage "https://github.com/Siguza/iokit-utils"
  url "https://github.com/Siguza/iokit-utils/archive/1.4.0.tar.gz"
  sha256 "076731d902717cf60a9c8b1b2a176a0ee0caf96354219f509bdd8675200231c4"
  license "MPL-2.0-no-copyleft-exception"
  head "https://github.com/Siguza/iokit-utils.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "ec0596c02b54e260d050ec75a417be8dcbeecad650570227e018b573e34aa277"
    sha256 cellar: :any_skip_relocation, big_sur:  "0ca1ef7c69ac3209298b1b6e21865b2b10feeeca3cd9c31ecb49ea633a93e2a1"
    sha256 cellar: :any_skip_relocation, catalina: "5a1562a863de6860dc9cf352efec3f88e143f8ad321f20f1b50d1acfc9f4b307"
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
