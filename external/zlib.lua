-- zlib 1.2.8
--   http://www.zlib.net/
--   http://zlib.net/zlib128.zip
--     /external/zlib
group "Libraries"

project "zlib"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"

	filter "configurations:Debug"
		targetname "zlib-d"
	filter{}

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
