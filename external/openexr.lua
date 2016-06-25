-- openexr 2.0.1
--   http://www.openexr.com/
--   https://codeload.github.com/openexr/openexr/zip/master
--     /external/openexr
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