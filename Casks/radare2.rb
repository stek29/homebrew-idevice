cask 'radare2' do
  version '3.6.0'
  sha256 '03f454d1a1583372a03aa5e4a81b44b027bc94d65201c15d2e68b6e58c4a8537'

  # radare.mikelloc.com was verified as official when first introduced to the cask
  url "http://radare.mikelloc.com/get/#{version}/radare2-#{version}.pkg"
  name 'Reverse engineering framework'
  homepage 'https://rada.re'
  name "Radare"

  pkg "radare2-#{version}.pkg"
  uninstall pkgutil: 'org.radare.radare2'
end

