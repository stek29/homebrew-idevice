class IosKernUtils < Formula
  desc "iOS Kernel utilities"
  homepage "https://github.com/Siguza/ios-kern-utils"
  url "https://github.com/Siguza/ios-kern-utils/archive/1.4.1.tar.gz"
  sha256 "24cf9d393d94cdd351691ed1f062bb02af6d0853783b762546ab89b4e29a156a"
  license "MIT"
  head "https://github.com/Siguza/ios-kern-utils.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey: "ee4ce3a58d895026c21caf4b30682dde636613a6d02c7815e9a7e1faed3ef241"
    sha256 cellar: :any_skip_relocation, big_sur:  "4130425f20828e8fae21b93230a9e55f2d162d49f8be69cf94accb278ec5c6ea"
    sha256 cellar: :any_skip_relocation, catalina: "dded795f5f2fa031258162dccbe42d5baf2448dc27cca0104b6d845311aa7bee"
  end

  def install
    system "make"

    cd "bin" do
      # Omitting nvpatch
      %w[kdump kinfo kmap kmem kpatch].each do |b|
        bin.install b
      end
    end
  end
end
