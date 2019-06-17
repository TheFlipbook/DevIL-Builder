-- libtiff 4.0.6
--   http://www.libtiff.org/
--   ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.6.zip
--     /external/libtiff
group "Libraries"

project "libtiff"
	kind "StaticLib"
	language "C++"
	location "../build/projects"
	targetdir "../build/lib/%{cfg.buildcfg}/%{cfg.platform}"
	
	filter "configurations:Debug"
		targetname "libtiff-d"
	filter{}

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