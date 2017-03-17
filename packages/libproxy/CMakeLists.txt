include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__cmake__add_cmake_arg(${package} WITH_PERL OFF)
byd__cmake__add_cmake_arg(${package} WITH_PYTHON OFF)
byd__cmake__add(${package})
