cask 'radare2' do
  version '3.3.0'
  sha256 '65c973bdefcfb8fc368daadf9f53b2b2f26305be054f7c8525ca2b2bd7c29e40'

  # radare.mikelloc.com was verified as official when first introduced to the cask
  url "http://radare.mikelloc.com/get/#{version}/radare2-#{version}.pkg"
  name 'Reverse engineering framework'
  homepage 'https://rada.re'
  name "Radare"

  pkg "radare2-#{version}.pkg"
  uninstall pkgutil: 'org.radare.radare2'
end

