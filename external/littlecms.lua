-- littlecms 2.7
--   http://www.littlecms.com/
--   https://codeload.github.com/mm2/Little-CMS/zip/master
--     /external/littlecms
group "Libraries"

project "littlecms"
	kind "StaticLib"
	language "C"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	targetname "lcms"
	
	filter "configurations:Debug"
		targetname "lcms-d"
	filter{}

	disablewarnings {
		"4267", -- loss of data in conversion (int)
	}
	
	-- Copy config back to DevIL's expected 1.0 version name
	--   Appears to be properly compatible
	os.copyfile( "./littlecms/include/lcms2.h", "../build/config/lcms.h" )
	
	includedirs {
		"./littlecms/include/"
	}
	
	files {
		"./littlecms/src/**.h",
		"./littlecms/src/**.c"
	}
