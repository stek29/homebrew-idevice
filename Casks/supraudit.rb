cask "supraudit" do
  version :latest
  sha256 :no_check

  url "http://newosxbook.com/tools/supraudit.tar"
  name "SUpraudit"
  desc "Actually useful praudit(1)"
  homepage "http://newosxbook.com/tools/supraudit.html"

  binary "usr/local/bin/supraudit"
  artifact "usr/share/man/manj/supraudit.j", target: "/usr/local/share/man/man1/supraudit.1"

  caveats do
    license "file:///#{@cask.staged_path.join("tmp/LICENSE")}"
  end
end
