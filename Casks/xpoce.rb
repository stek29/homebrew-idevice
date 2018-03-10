cask 'xpoce' do
  version :latest
  sha256 :no_check

  url 'http://www.newosxbook.com/tools/XPoCe'
  name 'XPoCe - XPC Snooping utilties for MacOS and iOS (version 2.0)'
  homepage 'http://www.newosxbook.com/tools/XPoCe2.html'

  binary 'XPoCe', target: 'xpoce'
end

