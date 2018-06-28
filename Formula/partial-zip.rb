class PartialZip < Formula
  desc "tool for image4 and der"
  homepage "https://github.com/xerub/img4tool"

  url "https://github.com/planetbeing/partial-zip.git"
  version "git0"

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
index fa44fe3b1460..a5e7ee4697bc 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,2 +32,5 @@
 ENDIF(BUILD_PARTIAL)
 
+install(TARGETS partialzip DESTINATION bin)
+install(TARGETS partial DESTINATION lib)
+install(FILES include/partial/partial.h DESTINATION include)
