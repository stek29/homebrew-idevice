class IosKernUtils < Formula
  desc "iOS Kernel utilities"
  homepage "https://github.com/Siguza/ios-kern-utils"
  url "https://github.com/Siguza/ios-kern-utils/archive/1.4.1.tar.gz"
  sha256 "24cf9d393d94cdd351691ed1f062bb02af6d0853783b762546ab89b4e29a156a"

  head "https://github.com/Siguza/ios-kern-utils.git"

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
