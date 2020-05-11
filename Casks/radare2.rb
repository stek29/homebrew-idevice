cask 'radare2' do
  version '4.3.1'
  sha256 '994c28cd7a890b526b4a89b2f64b7baceb2c199a3a2f3a82fe57b1382fae7b3b'

  # radare.mikelloc.com was verified as official when first introduced to the cask
  url "http://radare.mikelloc.com/get/#{version}/radare2-#{version}.pkg"
  name 'Reverse engineering framework'
  homepage 'https://rada.re'
  name "Radare"

  pkg "radare2-#{version}.pkg"
  uninstall pkgutil: 'org.radare.radare2'
end

