include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__set_dependency(freetype
    zlib
    bzip2
#    harfbuzz
    libpng
    )
