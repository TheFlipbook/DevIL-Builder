-- jasper 1.900.1
--   http://www.ece.uvic.ca/~frodo/jasper/
--   http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
--     /external/jasper/
group "Libraries"

project "jasper"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	targetname "libjasper"

	filter "configurations:Debug"
		targetname "libjasper-d"
	filter{}

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
