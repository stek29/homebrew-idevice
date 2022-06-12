cask 'xpoce' do
  url "http://newosxbook.com/tools/XPoCe#{version}.tgz"
  version "2.75"
  sha256 "62499494e072e6f75f9726e38ead34240e30135a1ac6980196ded519b2368d4d"

  name 'XPoCe'
  desc 'XPC Snooping utilties for MacOS and iOS (version 2.0)'
  homepage 'http://www.newosxbook.com/tools/XPoCe2.html'

  livecheck do
    url :homepage
    strategy :page_match
    regex(/a href="XPoCe([\d.]+).tgz"/m)
  end

  binary 'XPoCe', target: 'xpoce'
end
