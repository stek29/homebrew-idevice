cask 'rizin' do
    version '0.2.0'
    sha256 'b504c710e398e65d2abe292313eb2a1ec76fde4dfd33c4ea66d07cb8acef1125'

    url "https://github.com/rizinorg/rizin/releases/download/v#{version}/rizin-macos-v#{version}.pkg",
        verified: 'github.com/rizinorg/rizin/'
    name 'Fork of the radare2 reverse engineering framework'
    homepage 'https://rizin.re'
    name "Rizin"
  
    pkg "rizin-macos-v#{version}.pkg"
    uninstall pkgutil: 're.rizin.rizin'
  end
  
  