include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__set_dependency(${package}
    icu
    xz-util
    zlib
    )
