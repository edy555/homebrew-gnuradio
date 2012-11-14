require 'formula'

class GrAirModes < Formula
  homepage 'http://www.hamradioscience.com/the-rtl-2832u-sdr-and-ads-b/'
  head 'https://github.com/bistromath/gr-air-modes.git', :revision => '63c68feb'

  depends_on 'cmake' => :build
  depends_on 'gnuradio'
  depends_on 'rtlsdr'
  depends_on 'boost'
  depends_on 'swig'

  def patches
    DATA
  end

  def install
    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system 'make _air_modes_swig'
      system 'make'
      system 'make install'
    end
  end
end

__END__
diff --git a/lib/CMakeLists.txt b/lib/CMakeLists.txt
index 9ed79ae..4709d34 100644
--- a/lib/CMakeLists.txt
+++ b/lib/CMakeLists.txt
@@ -22,6 +22,8 @@
 ########################################################################
 include(GrPlatform) #define LIB_SUFFIX
 
+find_package(Boost COMPONENTS system) 
+
 add_library(air_modes SHARED
     air_modes_preamble.cc
     air_modes_slicer.cc
