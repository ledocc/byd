
include("${CMUT_ROOT}/utils/cmut__utils__canonical_path.cmake")

function(byd__option__private__make_absolute_cmake_path path result)

    file(TO_CMAKE_PATH "${path}" cmake_path)
    cmut__utils__canonical_path("${cmake_path}" "${CMAKE_BINARY_DIR}" absolute_cmake_path)

    byd__func__return(absolute_cmake_path)

endfunction()
