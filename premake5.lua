
solution "DevIL-Premake"
    configurations { "Debug", "Release" }
    platforms { "x32", "x64" }
    location "./build"

	
    defines {
		"JAS_WIN_MSVC_BUILD",	-- Windows for Jasper Header
		"USE_WIN32_FILEIO",     -- LibTiff Headers on Windows
		"IL_NO_WDP",			-- Skip license encumbered WDP format
		                        --   Available as jxrlib, but DevIL hardcodes some strange paths.
		"_WINDOWS",
		"_USRDLL",
		"IL_EXPORTS"
		}
	
	libdirs {
		"../external/lib/%{cfg.buildcfg}/%{cfg.platform}",
		"../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	}
	
    configuration "Debug"
        defines { "DEBUG" }
        symbols "On"

    configuration "Release"
        defines { "NDEBUG" }
        optimize "On"
		
	configuration "x32"
		defines { "_WIN32" } 
    
	configuration "x64"
		defines { "_WIN64" } 
	
    
    project "DevIL"
        kind "SharedLib"
        language "C++"
        location "./build/projects"
        targetdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/bin/"
		implibdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/lib/"
        
        os.mkdir( "./build/config/" )
        os.mkdir( "./build/config/IL" )
		os.mkdir( "./build/force_compile/" )
		
		-- No clean way to override IL_USE_DXTC_NVIDIA without editing the config.
		--   Copy over our copy of config.h, with the offending definiton removed
		--   Otherwise there would be a large dependency on NVTT.
        os.copyfile( "./override/config.h.win", "./build/config/IL/config.h" )
        
		disablewarnings {
            "4244", -- loss of data in conversion (float)
			"4311", -- pointer truncation
            "4477", -- variadic arguments to fprintf are inexact
		}
		
        includedirs {
            "./build/config/",
            "./external/jasper/src/libjasper/include/",
            "./external/libjpeg/",
            "./external/libmng/",
            "./external/libpng/",
            "./external/libtiff/libtiff/",
            "./external/littlecms/include/",
            "./external/openexr/IlmBase/Iex/",
            "./external/openexr/IlmBase/Imath/",
            "./external/openexr/IlmBase/Half/",
            "./external/openexr/OpenEXR/IlmImf/",
            "./external/squish/",
            "./external/zlib/",
            "./devil/DevIL/src-IL/include/",
            "./devil/DevIL/include/",
        }
		
		
        files {
            "./devil/DevIL/src-IL/src/**.h",
            "./devil/DevIL/src-IL/src/**.c",
			"./devil/DevIL/src-IL/src/**.cpp",
			
			-- Make ilFloatToHalf and ilHalfToFloat available to the linker
			--  Weird combination of defs keeps it out in MSVC builds
			"./override/force_compile_il_manip.c"
        }
		
		excludes {
			-- duplicate vestigal C files
            "./devil/DevIL/src-IL/src/il_exr.c",
			"./devil/DevIL/src-IL/src/il_utx.c",
        }
		
		links {
			"jasper",
			"libjpeg",
			"libmng",
			"libpng",
			"libtiff",
			"littlecms",
			"openexr",
			"squish",
			"zlib",
		}
		
		local devil_config = path.translate(path.getabsolute("./build/config/IL/config.h"))
		local devil_include_dir = path.translate(path.getabsolute("./devil/DevIL/include/IL/"))
		
		postbuildcommands {
			"{COPY} \"" .. devil_config .. "\" $(TargetDir)..\\include\\IL\\",
			"{COPY} \"" .. devil_include_dir .. "\\devil_cpp_wrapper.hpp\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\devil_internal_exports.h\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\il.h\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\ilu.h\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\ilu_region.h\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\ilut.h\" \"$(TargetDir)..\\include\\IL\\\"",
			"{COPY} \"" .. devil_include_dir .. "\\ilut_config.h\" \"$(TargetDir)..\\include\\IL\\\""
		}
        
    project "ILU"
        kind "SharedLib"
        language "C++"
        location "./build/projects"
        targetdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/bin/"
		implibdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/lib/"

        includedirs {
            "./build/config/",
            "./external/littlecms/include/",
            "./devil/DevIL/src-ILU/include/",
            "./devil/DevIL/include/",
        }
        
        files {
            "./devil/DevIL/src-ILU/src/**.h",
            "./devil/DevIL/src-ILU/src/**.c"
        }
		
		links {
			"DevIL"
		}
        
    project "ILUT"
        kind "SharedLib"
        language "C++"
        location "./build/projects"
        targetdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/bin/"
		implibdir "./bin/%{cfg.buildcfg}/%{cfg.platform}/lib/"

        includedirs {
            "./build/config/",
            "./external/littlecms/include/",
            "./devil/DevIL/src-ILUT/include/",
            "./devil/DevIL/include/",
        }
        
        files {
            "./devil/DevIL/src-ILUT/src/**.h",
            "./devil/DevIL/src-ILUT/src/**.c"
        }
		
		libdirs {
			os.getenv("DXSDK_DIR") .. "Lib/%{cfg.platform}/"
		}
		
		links {
			"DevIL",
			"ILU",
		}
		
	include "./external/external.lua"