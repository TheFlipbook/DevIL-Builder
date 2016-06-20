	group "Generators"
	
	project "openexr_generator_toFloat"
        kind "ConsoleApp"
        language "C++"
        location "../build/projects"
        targetdir "../build/gen/"
		targetprefix ""
		targetsuffix ""
		targetname "toFloat"
		
		defines { "NDEBUG" }
        flags { "Optimize" }
		
		disablewarnings {
			"4221", -- No previously undefined symbols
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4996", -- sprintf unsafe
        }
		
        files {
            "./openexr/IlmBase/Half/toFloat.cpp",
        }
		
		postbuildcommands {
			"%{cfg.buildtarget.abspath} > ../build/config/toFloat.h"
		}
		
		postbuildcommands {
			"$(TargetPath) > ..\\config\\toFloat.h"
		}
		
	project "openexr_generator_eLut"
        kind "ConsoleApp"
        language "C++"
        location "../build/projects"
        targetdir "../build/gen/"
		targetprefix ""
		targetsuffix ""
		targetname "eLut"
		
		defines { "NDEBUG" }
        flags { "Optimize" }
        
		disablewarnings {
			"4221", -- No previously undefined symbols
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4996", -- sprintf unsafe
        }
		
        files {
            "./openexr/IlmBase/Half/eLut.cpp",
        }
		
		postbuildcommands {
			"$(TargetPath) > ..\\config\\eLut.h"
		}
		
	project "openexr_generator_dwaLookups"
        kind "ConsoleApp"
        language "C++"
        location "../build/projects"
        targetdir "../build/gen/"
		targetprefix ""
		targetsuffix ""
		targetname "dwaLookups"
        
		
		defines { "NDEBUG" }
        flags { "Optimize" }
		
		disablewarnings {
			"4221", -- No previously undefined symbols
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4477", -- variadic arguments to fprintf are inexact
            "4996", -- sprintf unsafe
        }
		
		includedirs {
            "../build/config/",
			"./openexr/IlmBase/Iex/",
			"./openexr/IlmBase/IexMath/",
            "./openexr/IlmBase/Imath/",
            "./openexr/IlmBase/IlmThread/",
            "./openexr/IlmBase/Half/",
            "./openexr/OpenEXR/IlmImf/",
            "./openexr/OpenEXR/IlmImfUtil/",
            "./zlib/"
        }
		
        files {
            "./openexr/OpenEXR/IlmImf/dwaLookups.cpp",
			-- Could/Should use staticlibs, but just need to generate once
			"./openexr/IlmBase/Iex/**.cpp",
			"./openexr/IlmBase/IexMath/**.cpp",
            "./openexr/IlmBase/Imath/**.cpp",
            "./openexr/IlmBase/IlmThread/**.cpp",
            "./openexr/IlmBase/Half/**.cpp",
        }
		
		excludes {
			"./openexr/OpenEXR/IlmImf/b44ExpLogTable.cpp",
			"./openexr/IlmBase/Half/eLut.cpp",
			"./openexr/IlmBase/Half/toFloat.cpp",
		}
		
		postbuildcommands {
			"$(TargetPath) > ..\\config\\dwaLookups.h"
		}
		
		links {
			"openexr_generator_eLut",
			"openexr_generator_toFloat",
		}
	
	project "openexr_generator_b44ExpLogTable"
        kind "ConsoleApp"
        language "C++"
        location "../build/projects"
        targetdir "../build/gen/"
		targetprefix ""
		targetsuffix ""
		targetname "b44ExpLogTable"
        
		defines { "NDEBUG" }
        flags { "Optimize" }
		
		disablewarnings {
			"4221", -- No previously undefined symbols
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4996", -- sprintf unsafe
        }
		
		includedirs {
            "../build/config/",
			"./openexr/IlmBase/Iex/",
			"./openexr/IlmBase/IexMath/",
            "./openexr/IlmBase/Imath/",
            "./openexr/IlmBase/IlmThread/",
            "./openexr/IlmBase/Half/",
            "./openexr/OpenEXR/IlmImf/",
            "./openexr/OpenEXR/IlmImfUtil/",
            "./zlib/"
        }
		
        files {
            "./openexr/OpenEXR/IlmImf/b44ExpLogTable.cpp",
			-- Could/Should use staticlibs, but just need to generate once
			"./openexr/IlmBase/Iex/**.cpp",
			"./openexr/IlmBase/IexMath/**.cpp",
            "./openexr/IlmBase/Imath/**.cpp",
            "./openexr/IlmBase/IlmThread/**.cpp",
            "./openexr/IlmBase/Half/**.cpp",
        }
		
		excludes {
			"./openexr/OpenEXR/IlmImf/dwaLookups.cpp",
			"./openexr/IlmBase/Half/eLut.cpp",
			"./openexr/IlmBase/Half/toFloat.cpp",
		}
		
		postbuildcommands {
			"$(TargetPath) > ..\\config\\b44ExpLogTable.h"
		}
		
		
		links {
			"openexr_generator_eLut",
			"openexr_generator_toFloat",
		}
		
	group "Libraries"
	
    project "zlib"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"

        disablewarnings {
            "4996", -- POSIX name deprecated
        }

        files {
            "./zlib/**.h",
            "./zlib/**.c"
        }
        
        excludes {
            "./zlib/contrib/**",
            "./zlib/examples/**",
            "./zlib/test/**",
        }
		
	project "squish"
        kind "StaticLib"
        language "C++"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"

		includedirs {
            "./squish/"
        }
		
        files {
            "./squish/**.h",
            "./squish/**.cpp"
        }
        
        excludes {
            "./squish/extra/**"
        }
	
    project "libmng"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"

        disablewarnings {
            "4101", -- Unreferenced local variable
            "4267", -- loss of data in conversion (int)
        }
        
        includedirs {
            "../build/config/",
            "./libjpeg",
            "./zlib/"
        }
        
        files {
            "./libmng/**.h",
            "./libmng/**.c"
        }
        
        excludes {
            "./libmng/bcb/**",
            "./libmng/contrib/**",
            "./libmng/delphi/**",
            "./libmng/doc/**",
            "./libmng/makefiles/**",
            "./libmng/special/**",
            "./libmng/Unix/**",
            "./libmng/unmaintained/**",
        }

	
    project "openexr"
        kind "StaticLib"
        language "C++"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
        
        disablewarnings {
			"4018", -- Signed/Unsigned mismatch
			"4099", -- Forward declear mismatch for class versus struct for Imf::Channel
			"4221", -- No previously undefined symbols
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4305", -- truncation from double to float
            "4302", -- pointer truncation
            "4311", -- pointer truncation
            "4312", -- Conversion to thandle_t of greater size
            "4334", -- result of 32-bit shift implicitly converted to 64 bits in imfRgbaFile
            "4715", -- Not all control paths return a value in dataWindowForFile
            "4800", -- int forced to bool
            "4996", -- sprintf unsafe
            --"4267", -- loss of data in conversion (int)
        }
        
		linkoptions {
			"/ignore:4221"
		}
		
		os.copyfile( "./openexr/IlmBase/config.windows/IlmBaseConfig.h", "../build/config/IlmBaseConfig.h" )
		os.copyfile( "./openexr/OpenEXR/config.windows/OpenEXRConfig.h", "../build/config/OpenEXRConfig.h" )
		
        includedirs {
            "../build/config/",
			"./openexr/IlmBase/Iex/",
			"./openexr/IlmBase/IexMath/",
            "./openexr/IlmBase/Imath/",
            "./openexr/IlmBase/IlmThread/",
            "./openexr/IlmBase/Half/",
            "./openexr/OpenEXR/IlmImf/",
            "./openexr/OpenEXR/IlmImfUtil/",
            "./zlib/"
        }
        
        files {
            "./openexr/**.h",
            "./openexr/**.cpp"
        }
		
        excludes {
            "./openexr/Contrib/**",
			"./openexr/OpenEXR_Viewers/**",
			"./openexr/PyIlmBase/**",
			"./openexr/IlmBase/HalfTest/**",
			"./openexr/IlmBase/IexTest/**",
			"./openexr/IlmBase/ImathTest/**",
			"./openexr/OpenEXR/exr2aces/**",
			"./openexr/OpenEXR/exrbuild/**",
			"./openexr/OpenEXR/exrenvmap/**",
			"./openexr/OpenEXR/exrheader/**",
			"./openexr/OpenEXR/exrmakepreview/**",
			"./openexr/OpenEXR/exrmaketiled/**",
			"./openexr/OpenEXR/exrmultipart/**",
			"./openexr/OpenEXR/exrmultiview/**",
			"./openexr/OpenEXR/exrstdattr/**",
			"./openexr/OpenEXR/IlmImfExamples/**",
			"./openexr/OpenEXR/IlmImfFuzzTest/**",
			"./openexr/OpenEXR/IlmImfTest/**",
			"./openexr/OpenEXR/IlmImfUtilTest/**",
			-- Generators
			"./openexr/OpenEXR/IlmImf/b44ExpLogTable.cpp",
			"./openexr/OpenEXR/IlmImf/dwaLookups.cpp",
			"./openexr/IlmBase/Half/eLut.cpp",
			"./openexr/IlmBase/Half/toFloat.cpp",
        }
		
		links {
			"openexr_generator_b44ExpLogTable",
			"openexr_generator_dwaLookups",
			"openexr_generator_eLut",
			"openexr_generator_toFloat",
		}
		
		
	project "littlecms"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
		targetname "lcms"
        
        disablewarnings {
            "4267", -- loss of data in conversion (int)
        }
		
		-- Copy 
        os.copyfile( "./littlecms/include/lcms2.h", "../build/config/lcms.h" )
        
        includedirs {
            "./littlecms/include/"
        }
        
        files {
            "./littlecms/src/**.h",
            "./littlecms/src/**.c"
        }
        
        
    project "jasper"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
		targetname "libjasper"
        
        defines { "JAS_WIN_MSVC_BUILD" }
        
        disablewarnings {
            "4005", -- Redefintion, 'HAVE_STDDEF_H'
            "4013", -- assumed external int function
            "4018", -- signed/unsigned mismatch
            "4244", -- loss of data in conversion (float)
            "4267", -- loss of data in conversion (int)
            "4477", -- variadic arguments to fprintf are inexact
            "4996", -- sprintf unsafe
        } 
        
        includedirs {
            "../build/config/",
            "./libjpeg",
            "./jasper/src/libjasper/include/"
        }
        
        files {
            "./jasper/src/libjasper/**.h",
            "./jasper/src/libjasper/**.c"
        }
        
        excludes {
            "./jasper/src/libjasper/jpg/jpg_dummy.c"
        }
            

    project "libjpeg"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
        
        disablewarnings {
            "4267", -- loss of data in conversion (int)
            "4996", -- POSIX name deprecated
        }
        
        os.copyfile( "./libjpeg/jconfig.vc", "../build/config/jconfig.h" )
        
        includedirs {
            "../build/config/",
        }
        
        files {
            "./libjpeg/**.h",
            "./libjpeg/**.c"
        }
        
        excludes {
            "./libjpeg/jmemansi.c",
            "./libjpeg/jmemdos.c",
            "./libjpeg/jmemmac.c",
            "./libjpeg/jmemname.c",
            "./libjpeg/rdjpgcom.c",
            "./libjpeg/wrjpgcom.c",
            "./libjpeg/jpegtran.c",
            "./libjpeg/djpeg.c",
            "./libjpeg/cjpeg.c",
            "./libjpeg/example.c",
            "./libjpeg/ckconfig.c"
        }
           
           
    project "libpng"
        kind "StaticLib"
        language "C"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
        
        disablewarnings {
            "4996", -- sprintf unsafe
        } 
        
        os.copyfile( "./libpng/scripts/pnglibconf.h.prebuilt", "../build/config/pnglibconf.h" )
        
        includedirs {
            "../build/config/",
            "./zlib/"
        }
        
        files {
            "./libpng/**.h",
            "./libpng/**.c"
        }
        
        excludes {
            "./libpng/arm/**",
            "./libpng/scripts/**",
            "./libpng/tests/**",
            "./libpng/contrib/**"
        }
            
            
    project "libtiff"
        kind "StaticLib"
        language "C++"
        location "../build/projects"
        targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
        
        os.copyfile( "./libtiff/libtiff/tif_config.vc.h", "../build/config/tif_config.h" )
        os.copyfile( "./libtiff/libtiff/tiffconf.vc.h", "../build/config/tiffconf.h" )
        
        defines { "USE_WIN32_FILEIO", "HAVE_SNPRINTF" }
        
        disablewarnings {
            "4133", -- LPCTSTR conversion incorrect in tif_win32.c
            "4311", -- pointer truncation
            "4312", -- Conversion to thandle_t of greater size
			
        } 
        
        includedirs {
            "../build/config/"
        }
        
        files {
            "./libtiff/libtiff/t4.h",
            "./libtiff/libtiff/tiff.h",
            "./libtiff/libtiff/tiffio.h",
            "./libtiff/libtiff/tiffio.hxx",
            "./libtiff/libtiff/tiffiop.h",
            "./libtiff/libtiff/tiffvers.h",
            "./libtiff/libtiff/uvcode.h",
            "./libtiff/libtiff/tif_aux.c",
            "./libtiff/libtiff/tif_close.c",
            "./libtiff/libtiff/tif_codec.c",
            "./libtiff/libtiff/tif_color.c",
            "./libtiff/libtiff/tif_compress.c",
            "./libtiff/libtiff/tif_dir.c",
            "./libtiff/libtiff/tif_dir.h",
            "./libtiff/libtiff/tif_dirinfo.c",
            "./libtiff/libtiff/tif_dirread.c",
            "./libtiff/libtiff/tif_dirwrite.c",
            "./libtiff/libtiff/tif_dumpmode.c",
            "./libtiff/libtiff/tif_error.c",
            "./libtiff/libtiff/tif_extension.c",
            "./libtiff/libtiff/tif_fax3.c",
            "./libtiff/libtiff/tif_fax3.h",
            "./libtiff/libtiff/tif_fax3sm.c",
            "./libtiff/libtiff/tif_getimage.c",
            "./libtiff/libtiff/tif_jpeg.c",
            "./libtiff/libtiff/tif_ojpeg.c",
            "./libtiff/libtiff/tif_flush.c",
            "./libtiff/libtiff/tif_luv.c",
            "./libtiff/libtiff/tif_lzw.c",
            "./libtiff/libtiff/tif_next.c",
            "./libtiff/libtiff/tif_open.c",
            "./libtiff/libtiff/tif_packbits.c",
            "./libtiff/libtiff/tif_pixarlog.c",
            "./libtiff/libtiff/tif_predict.c",
            "./libtiff/libtiff/tif_predict.h",
            "./libtiff/libtiff/tif_print.c",
            "./libtiff/libtiff/tif_read.c",
            "./libtiff/libtiff/tif_stream.cxx",
            "./libtiff/libtiff/tif_swab.c",
            "./libtiff/libtiff/tif_strip.c",
            "./libtiff/libtiff/tif_thunder.c",
            "./libtiff/libtiff/tif_tile.c",
            "./libtiff/libtiff/tif_version.c",
            "./libtiff/libtiff/tif_warning.c",
            "./libtiff/libtiff/tif_write.c",
            "./libtiff/libtiff/tif_zip.c",
            "./libtiff/libtiff/tif_win32.c",
        }