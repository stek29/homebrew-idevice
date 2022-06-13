class Futurerestore < Formula
  desc "Hacked up idevicerestore wrapper"
  homepage "https://github.com/futurerestore/futurerestore"
  url "https://github.com/futurerestore/futurerestore.git",
    revision: "ecc32003b09a3afb27be80fd881cee9fcc0b5d49"
  version "276"
  license "LGPL-3.0-or-later"
  head "https://github.com/futurerestore/futurerestore.git", branch: "test"

  livecheck do
    skip "cmake builds are broken, see https://github.com/futurerestore/futurerestore/issues/75"
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    sha256 cellar: :any, monterey: "1dd4b0f85e51c24a02623e6e7b62478e7428f5f68cebdbd70d9aa2880a4d570d"
    sha256 cellar: :any, big_sur:  "975ff1112c7464cdfbeb1dff1ea81295b56812c0f3f7bce357fe5184d2465a99"
    sha256 cellar: :any, catalina: "b452adda5c794295348d9b7358ba7fed1a433a7057e694abb1df9de1cf949dc0"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "img4tool"
  depends_on "libfragmentzip"
  depends_on "libzip"

  depends_on "stek29/idevice/libimobiledevice"
  depends_on "stek29/idevice/libirecovery"
  depends_on "stek29/idevice/libplist"
  depends_on "tsschecker"

  # https://github.com/libimobiledevice/idevicerestore/commit/f80a876b3598de4eb551bafcb279947c527fae33
  patch :DATA

  def fix_tihmstar
    inreplace %w[configure.ac],
      "git rev-list --count HEAD",
      "echo #{version.to_s.gsub(/[^\d]/, "")}",
      false
  end

  def install
    fix_tihmstar

    system "./autogen.sh",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"

    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      this is not the "official" tihmstar/futurerestore, but a maintained fork from futurerestore/futurerestore

      due to issues with upstream build system, building newer versions is not possibe,
      see https://github.com/futurerestore/futurerestore/issues/75 for details

      due to upstream limitations, it bundles its own versions of tsschecker and idevicerestore
    EOS
  end

  test do
    # version format:
    #  v2.0.0-test($(git rev-parse HEAD)-$(git rev-list --count HEAD))
    assert_equal version.to_s, shell_output("#{bin}/futurerestore", 255)
      .split("\n")
      .first.match(/Version: v2.0.0-test\([^-]*-(\d+)\)/).captures.first
  end
end

__END__
diff --git a/external/idevicerestore/src/ipsw.c b/external/idevicerestore/src/ipsw.c
index 03e10c2..f861241 100644
--- a/external/idevicerestore/src/ipsw.c
+++ b/external/idevicerestore/src/ipsw.c
@@ -152,10 +152,10 @@ int ipsw_print_info(const char* path)
 		plist_get_string_val(val, &build_ver);
 	}
 
-	cprintf(COLOR_WHITE "Product Version: " COLOR_BRIGHT_YELLOW "%s" COLOR_RESET COLOR_WHITE "   Build: " COLOR_BRIGHT_YELLOW "%s" COLOR_RESET "\n", prod_ver, build_ver);
+	cprintf(FG_WHITE "Product Version: " FG_BRIGHT_YELLOW "%s" COLOR_RESET FG_WHITE "   Build: " FG_BRIGHT_YELLOW "%s" COLOR_RESET "\n", prod_ver, build_ver);
 	free(prod_ver);
 	free(build_ver);
-	cprintf(COLOR_WHITE "Supported Product Types:" COLOR_RESET);
+	cprintf(FG_WHITE "Supported Product Types:" COLOR_RESET);
 	val = plist_dict_get_item(manifest, "SupportedProductTypes");
 	if (val) {
 		plist_array_iter iter = NULL;
@@ -167,7 +167,7 @@ int ipsw_print_info(const char* path)
 				if (item) {
 					char* item_str = NULL;
 					plist_get_string_val(item, &item_str);
-					cprintf(" " COLOR_BRIGHT_CYAN "%s" COLOR_RESET, item_str);
+					cprintf(" " FG_BRIGHT_CYAN "%s" COLOR_RESET, item_str);
 					free(item_str);
 				}
 			} while (item);
@@ -176,7 +176,7 @@ int ipsw_print_info(const char* path)
 	}
 	cprintf("\n");
 
-	cprintf(COLOR_WHITE "Build Identities:" COLOR_RESET "\n");
+	cprintf(FG_WHITE "Build Identities:" COLOR_RESET "\n");
 
 	plist_t build_ids_grouped = plist_new_dict();
 
@@ -232,7 +232,7 @@ int ipsw_print_info(const char* path)
 			group_no++;
 			node = plist_dict_get_item(group, "RestoreBehavior");
 			plist_get_string_val(node, &rbehavior);
-			cprintf("  " COLOR_WHITE "[%d] Variant: " COLOR_BRIGHT_CYAN "%s" COLOR_WHITE "   Behavior: " COLOR_BRIGHT_CYAN "%s" COLOR_RESET "\n", group_no, key, rbehavior);
+			cprintf("  " FG_WHITE "[%d] Variant: " FG_BRIGHT_CYAN "%s" FG_WHITE "   Behavior: " FG_BRIGHT_CYAN "%s" COLOR_RESET "\n", group_no, key, rbehavior);
 			free(key);
 			free(rbehavior);
 
@@ -285,9 +285,9 @@ int ipsw_print_info(const char* path)
 
 				irecv_device_t irecvdev = NULL;
 				if (irecv_devices_get_device_by_hardware_model(hwmodel, &irecvdev) == 0) {
-					cprintf("    ChipID: " COLOR_GREEN "%04x" COLOR_RESET "   BoardID: " COLOR_GREEN "%02x" COLOR_RESET "   Model: " COLOR_YELLOW "%-8s" COLOR_RESET "  " COLOR_MAGENTA "%s" COLOR_RESET "\n", (int)chip_id, (int)board_id, hwmodel, irecvdev->display_name);
+					cprintf("    ChipID: " FG_GREEN "%04x" COLOR_RESET "   BoardID: " FG_GREEN "%02x" COLOR_RESET "   Model: " FG_YELLOW "%-8s" COLOR_RESET "  " FG_MAGENTA "%s" COLOR_RESET "\n", (int)chip_id, (int)board_id, hwmodel, irecvdev->display_name);
 				} else {
-					cprintf("    ChipID: " COLOR_GREEN "%04x" COLOR_RESET "   BoardID: " COLOR_GREEN "%02x" COLOR_RESET "   Model: " COLOR_YELLOW "%s" COLOR_RESET "\n", (int)chip_id, (int)board_id, hwmodel);
+					cprintf("    ChipID: " FG_GREEN "%04x" COLOR_RESET "   BoardID: " FG_GREEN "%02x" COLOR_RESET "   Model: " FG_YELLOW "%s" COLOR_RESET "\n", (int)chip_id, (int)board_id, hwmodel);
 				}
 				free(hwmodel);
 			} while (build_id);
