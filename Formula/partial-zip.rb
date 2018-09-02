class PartialZip < Formula
  desc "retrieve selected portions of ZIP files"
  homepage "https://github.com/planetbeing/partial-zip"

  url "https://github.com/planetbeing/partial-zip.git"
  version "git0"
  revision 1

  depends_on "cmake" => :build
  depends_on "zlib"

  # https://github.com/planetbeing/partial-zip/pull/3
  patch :DATA

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,2 +32,5 @@
 ENDIF(BUILD_PARTIAL)
 
+install(TARGETS partialzip DESTINATION bin)
+install(TARGETS partial DESTINATION lib)
+install(FILES include/partial/partial.h DESTINATION include)

diff --git a/main.c b/main.c
--- a/main.c
+++ b/main.c
@@ -16,3 +16,4 @@
	char* extract = argv[2];
        char fname[strlen(argv[1]) + sizeof("file://")];
+        fname[0] = '\0';
	char* outfile = argv[2];
