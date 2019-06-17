-- libmng 1.0.10
--   http://libmng.com/
--   http://prdownloads.sourceforge.net/libmng/lm010010.zip?download
--     /external/libmng
group "Libraries"

project "libmng"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"

	filter "configurations:Debug"
		targetname "libmng-d"
	filter{}

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
