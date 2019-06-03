# DevIL Builder
A set of premake scripts for rebuilding DevIL binaries from source.

This allows for easier porting to newer Visual Studio versions.

DevIL: https://github.com/DentonW/DevIL
Premake: https://premake.github.io

## How To Build
1. clone this repository to a folder
2. clone or copy DevIL's repo in to the "devil" subfolder
3. for each library in "external" copy it's release into a subfolder with the same name as its premake file
..* Each premake file contains detailed instructions for each library
..* Jasper: http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
..* LibJPEG: http://www.ijg.org/files/jpegsr9b.zip
..* LibMNG: http://prdownloads.sourceforge.net/libmng/lm010010.zip?download
..* LibPNG: https://codeload.github.com/glennrp/libpng/zip/libpng16
..* LibTIFF: ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.6.zip
..* LittleCMS: https://codeload.github.com/mm2/Little-CMS/zip/master
..* OpenEXR: https://codeload.github.com/openexr/openexr/zip/master
..* Squish: https://code.google.com/archive/p/libsquish/downloads
..* ZLib: http://zlib.net/zlib128.zip
4. run premake5.exe on this folder.
5. Open ./build/DeviIL-Premake.sln
6. Compile in the desired configuration
7. Use outputs in ./bin/$(Configuration)/$(Platform)/
..* bin: DLLs
..* include: DevIL Headers
..* lib: Static imports for DLL