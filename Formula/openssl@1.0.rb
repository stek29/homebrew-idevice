# combined from:
#  https://github.com/Homebrew/homebrew-core/pull/46876
#  https://github.com/rbenv/homebrew-tap
#  https://github.com/felixbuenemann/homebrew-tap/blob/updates/Formula/openssl%401.0.rb
#  https://github.com/Firefishy/homebrew-tap/blob/additional-cabundle-keychain-seed/Formula/openssl%401.0.rb
class OpensslAT10 < Formula
  desc "SSL/TLS cryptography library"
  homepage "https://openssl.org/"
  url "https://www.openssl.org/source/openssl-#{version}.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.openssl.org/source/openssl-#{version}.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.openssl.org/source/openssl-#{version}.tar.gz"
  mirror "http://www.mirrorservice.org/sites/ftp.openssl.org/source/openssl-#{version}.tar.gz"
  mirror "https://www.openssl.org/source/old/1.0.2/openssl-#{version}.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.openssl.org/source/old/1.0.2/openssl-#{version}.tar.gz"
  mirror "http://www.mirrorservice.org/sites/ftp.openssl.org/source/old/1.0.2/openssl-#{version}.tar.gz"
  version "1.0.2u"
  sha256 "ecd0c6ffb493dd06707d38b14bb4d8c2288bb7033735606569d8f90f89669d16"

  # not using provided_by_macos because brew style doesn't like it:
  # Formulae that are keg_only :provided_by_macos should be added to the PROVIDED_BY_MACOS_FORMULAE
  keg_only <<~EOS
    it's an outdated version of OpenSSL, and it's also provided by macOS
  EOS
  depends_on "ca-certificates"

  # Add darwin64-arm64-cc & debug-darwin64-arm64-cc build targets.
  patch :DATA

  def install
    # OpenSSL will prefer the PERL environment variable if set over $PATH
    # which can cause some odd edge cases & isn't intended. Unset for safety,
    # along with perl modules in PERL5LIB.
    ENV.delete("PERL")
    ENV.delete("PERL5LIB")

    ENV.deparallelize
    args = %W[
      --prefix=#{prefix}
      --openssldir=#{openssldir}
      no-ssl2
      no-ssl3
      no-zlib
      shared
      enable-cms
      darwin64-#{Hardware::CPU.arch}-cc
      enable-ec_nistp_64_gcc_128
    ]
    system "perl", "./Configure", *args
    system "make", "depend"
    system "make"
    system "make", "test"
    system "make", "install", "MANDIR=#{man}", "MANSUFFIX=ssl"
  end

  def openssldir
    etc/"openssl@1.0"
  end

  def post_install
    rm_f openssldir/"cert.pem"
    openssldir.install_symlink Formula["ca-certificates"].pkgetc/"cert.pem"
  end

  def caveats
    <<~EOS
      A CA file has been bootstrapped using certificates from the SystemRoots
      keychain. To add additional certificates (e.g. the certificates added in
      the System keychain), place .pem files in
        #{openssldir}/certs

      and run
        #{opt_bin}/c_rehash
    EOS
  end

  test do
    # Make sure the necessary .cnf file exists, otherwise OpenSSL gets moody.
    assert_predicate pkgetc/"openssl.cnf", :exist?,
            "OpenSSL requires the .cnf file for some functionality"

    # Check OpenSSL itself functions as expected.
    (testpath/"testfile.txt").write("This is a test file")
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    system "#{bin}/openssl", "dgst", "-sha256", "-out", "checksum.txt", "testfile.txt"
    open("checksum.txt") do |f|
      checksum = f.read(100).split("=").last.strip
      assert_equal checksum, expected_checksum
    end
  end
end

__END__
--- openssl-1.0.2u/Configure	2019-12-20 14:02:41.000000000 +0100
+++ openssl-1.0.2u/Configure	2020-11-22 17:03:42.000000000 +0100
@@ -650,7 +650,9 @@
 "darwin-i386-cc","cc:-arch i386 -O3 -fomit-frame-pointer -DL_ENDIAN::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:BN_LLONG RC4_INT RC4_CHUNK DES_UNROLL BF_PTR:".eval{my $asm=$x86_asm;$asm=~s/cast\-586\.o//;$asm}.":macosx:dlfcn:darwin-shared:-fPIC -fno-common:-arch i386 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
 "debug-darwin-i386-cc","cc:-arch i386 -g3 -DL_ENDIAN::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:BN_LLONG RC4_INT RC4_CHUNK DES_UNROLL BF_PTR:${x86_asm}:macosx:dlfcn:darwin-shared:-fPIC -fno-common:-arch i386 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
 "darwin64-x86_64-cc","cc:-arch x86_64 -O3 -DL_ENDIAN -Wall::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:SIXTY_FOUR_BIT_LONG RC4_CHUNK DES_INT DES_UNROLL:".eval{my $asm=$x86_64_asm;$asm=~s/rc4\-[^:]+//;$asm}.":macosx:dlfcn:darwin-shared:-fPIC -fno-common:-arch x86_64 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
+"darwin64-arm64-cc","cc:-arch arm64 -O3 -DL_ENDIAN -Wall::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:SIXTY_FOUR_BIT_LONG RC4_CHUNK DES_INT DES_UNROLL:${no_asm}:dlfcn:darwin-shared:-fPIC -fno-common:-arch arm64 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
 "debug-darwin64-x86_64-cc","cc:-arch x86_64 -ggdb -g2 -O0 -DL_ENDIAN -Wall::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:SIXTY_FOUR_BIT_LONG RC4_CHUNK DES_INT DES_UNROLL:".eval{my $asm=$x86_64_asm;$asm=~s/rc4\-[^:]+//;$asm}.":macosx:dlfcn:darwin-shared:-fPIC -fno-common:-arch x86_64 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
+"debug-darwin64-arm64-cc","cc:-arch arm64 -ggdb -g2 -O0 -DL_ENDIAN -Wall::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:SIXTY_FOUR_BIT_LONG RC4_CHUNK DES_INT DES_UNROLL:${no_asm}:dlfcn:darwin-shared:-fPIC -fno-common:-arch arm64 -dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
 "debug-darwin-ppc-cc","cc:-DBN_DEBUG -DREF_CHECK -DCONF_DEBUG -DCRYPTO_MDEBUG -DB_ENDIAN -g -Wall -O::-D_REENTRANT:MACOSX::BN_LLONG RC4_CHAR RC4_CHUNK DES_UNROLL BF_PTR:${ppc32_asm}:osx32:dlfcn:darwin-shared:-fPIC:-dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",
 # iPhoneOS/iOS
 "iphoneos-cross","llvm-gcc:-O3 -isysroot \$(CROSS_TOP)/SDKs/\$(CROSS_SDK) -fomit-frame-pointer -fno-common::-D_REENTRANT:iOS:-Wl,-search_paths_first%:BN_LLONG RC4_CHAR RC4_CHUNK DES_UNROLL BF_PTR:${no_asm}:dlfcn:darwin-shared:-fPIC -fno-common:-dynamiclib:.\$(SHLIB_MAJOR).\$(SHLIB_MINOR).dylib",

