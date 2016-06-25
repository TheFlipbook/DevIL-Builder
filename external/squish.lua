-- squish 1.11.0
--   https://code.google.com/archive/p/libsquish/
--   https://code.google.com/archive/p/libsquish/downloads
--     /external/squish
group "Libraries"

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