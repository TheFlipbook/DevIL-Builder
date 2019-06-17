-- libjpeg 9b
--   http://www.ijg.org/
--   http://www.ijg.org/files/jpegsr9b.zip
--     /external/libjpeg
group "Libraries"

project "libjpeg"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	
	filter "configurations:Debug"
		targetname "libjpeg-d"
	filter{}

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
