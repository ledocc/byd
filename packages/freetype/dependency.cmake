include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__define_dependency(freetype
    zlib
    bzip2
#    harfbuzz
    libpng
    )
