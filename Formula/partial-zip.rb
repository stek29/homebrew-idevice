class PartialZip < Formula
  desc "Retrieve selected portions of ZIP files"
  homepage "https://github.com/planetbeing/partial-zip"

  url "https://github.com/planetbeing/partial-zip.git",
    revision: "1060554ccb77ffc95de70afd3248a9142ca1715c"
  version "0.7"

  head "https://github.com/planetbeing/partial-zip.git", branch: "master"

  livecheck do
    url :url
    regex(%r{<strong>(\d+)</strong>\s*<span aria-label="Commits}im)
    strategy :page_match do |page|
      v = page.match(regex)&.captures&.first
      "0.#{v}" if v
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/stek29/idevice"
    rebuild 1
    sha256 cellar: :any, monterey: "1e34c953fbda90004174b286296a2cae43b020d8bc9c010d474572138f5400d8"
    sha256 cellar: :any, big_sur:  "e7768e349cb6b8d00b796af1c2bc534610f112ff3f6769f5bc95054ac04cfda7"
    sha256 cellar: :any, catalina: "eb63c45d232172241d91246740299c182dd09e7436938ccfaa0e0feb5ea83de2"
  end

  depends_on "cmake" => :build
  depends_on "zlib"

  uses_from_macos "zip" => :test

  # https://github.com/planetbeing/partial-zip/pull/3
  patch :DATA

  def install
    args = *std_cmake_args + %W[
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    mkdir "build" do
      system "cmake", "..", *args, "-DBUILD_SHARED_LIBS=ON"
      system "make", "install"

      system "make", "clean"
      system "cmake", "..", *args, "-DBUILD_SHARED_LIBS=OFF"
      system "make"
      lib.install "libpartial.a"
    end
  end

  test do
    test_data = <<~EOS
      this is a test file
      zipped and unzipped!
    EOS
    (testpath/"test.txt").write test_data
    system "zip", "test.zip", "test.txt"
    system "#{bin}/partialzip", "file://#{testpath}/test.zip", "test.txt", "extracted.txt"
    assert_equal test_data, (testpath/"extracted.txt").read
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
