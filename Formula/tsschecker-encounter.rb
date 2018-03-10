class TsscheckerEncounter < Formula
  desc "Tool to check tss signing status of various devices"
  homepage "https://github.com/encounter/tsschecker"
  url "https://github.com/encounter/tsschecker.git",
    :tag => "v268",
    :revision => "9ce5e00fdeaba8d7e763a028d32b11937839d2f9"

  head "https://github.com/encounter/tsschecker.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libfragmentzip"
  depends_on "libirecovery"

  conflicts_with "tsschecker", :because => "it's an unofficial fork"

  def fix_tihmstar
    mkdir_p "m4"

    if File.symlink?("COPYING")
      rm "COPYING"
      if File.exist?("LICENSE")
        cp "LICENSE", "COPYING"
      else
        touch "COPYING"
      end
    end

    vers = version.to_s.sub /[^\d]/, ""
    inreplace(File.exist?("setBuildVersion.sh") ? "setBuildVersion.sh" : "autogen.sh", "$(git rev-list --count HEAD)", vers)
  end

  def install
    fix_tihmstar

    # smh it doesnt link properly on it's own
    ENV.append "LDFLAGS", "-lplist -lirecovery"

    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"

    # we don't need libjssy.a/fragmentzip/idevicerestore.1
    # system "make", "install"

    # fix fragmentzip issue
    # See https://github.com/tihmstar/tsschecker/commit/f8644fabb1adb04fc0ee42860fd7d2e0469823dc#commitcomment-28027109
    f = MachO::MachOFile.new("tsschecker/.libs/tsschecker")
    old_name = f.linked_dylibs.select { |fn| fn =~ /libfragmentzip/ } .first
    new_name = MachO::MachOFile.new("#{Formula["libfragmentzip"].opt_lib}/libfragmentzip.dylib").dylib_id
    f.change_install_name(old_name, new_name)
    f.write("tsschecker-fixed")

    bin.install "tsschecker-fixed" => "tsschecker"
  end
end
