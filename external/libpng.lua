-- libpng 1.6.22
--   http://www.libpng.org/pub/png/libpng.html
--   https://codeload.github.com/glennrp/libpng/zip/libpng16
--     /external/libpng
group "Libraries"

project "libpng"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	
	filter "configurations:Debug"
		targetname "libpng-d"
	filter{}

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
