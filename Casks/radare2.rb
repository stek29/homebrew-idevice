cask 'radare2' do
  version '3.2.1'
  sha256 '936f66d1197d341c1b7c715ece77f9aca860e4e96efe7c61f8ac5b66f3e7dfcd'

  # radare.mikelloc.com was verified as official when first introduced to the cask
  url "http://radare.mikelloc.com/get/#{version}/radare2-#{version}.pkg"
  name 'Reverse engineering framework'
  homepage 'https://rada.re'
  name "Radare"

  pkg "radare2-#{version}.pkg"
  uninstall pkgutil: 'org.radare.radare2'
end

