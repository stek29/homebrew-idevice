cask 'supraudit' do
  version :latest
  sha256 :no_check

  url 'http://newosxbook.com/tools/supraudit.tar'
  name 'SUpraudit - An actually useful praudit(1) for MacOS'
  homepage 'http://newosxbook.com/tools/supraudit.html'

  binary 'usr/local/bin/supraudit'
  artifact 'usr/share/man/manj/supraudit.j', target: '/usr/local/share/man/man1/supraudit.1'

  caveats do
    lic_path = @cask.staged_path.join('tmp/LICENSE')
    ar = []
    ar << 'Installing this Cask means you have AGREED to the'
    ar << 'following license:'
    ar << ''
    ar << File.read(lic_path)

    ar.join "\n"
  end
end

