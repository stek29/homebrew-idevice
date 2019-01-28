class TsscheckerS0uthwest < Formula
  desc "Tool to check tss signing status of various devices"
  homepage "https://github.com/s0uthwest/tsschecker"
  # Not using tag because s0uthwest tends to delete tags for no reason
  url "https://github.com/s0uthwest/tsschecker.git",
    :revision => "9be4a1cd83ba0a38082b0634b3a0ade8526f2733"
  version "330"

  head "https://github.com/s0uthwest/tsschecker.git"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  depends_on "libfragmentzip"
  depends_on "libirecovery"

  conflicts_with "tsschecker", :because => "it's an unofficial fork"

  def fix_tihmstar
    if File.symlink?("COPYING")
      rm "COPYING"
      touch "LICENSE"
      cp "LICENSE", "COPYING"
    end

    files = %w[setBuildVersion.sh autogen.sh configure.ac]
    inreplace files.select { |f| File.exist? f },
      "$(git rev-list --count HEAD)",
      version.to_s.gsub(/[^\d]/, ""),
      false
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
    bin.install "tsschecker"
  end
end
