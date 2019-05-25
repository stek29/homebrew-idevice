cask 'radare2' do
  version '3.5.1'
  sha256 '197db4400a27bb1a313c0ede7c8227c36e9e16cb9222bec28a81e578cf26d05e'

  # radare.mikelloc.com was verified as official when first introduced to the cask
  url "http://radare.mikelloc.com/get/#{version}/radare2-#{version}.pkg"
  name 'Reverse engineering framework'
  homepage 'https://rada.re'
  name "Radare"

  pkg "radare2-#{version}.pkg"
  uninstall pkgutil: 'org.radare.radare2'
end

