include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__cmake__add_cmake_arg(${package} WITH_PERL OFF)
byd__cmake__add_cmake_arg(${package} WITH_PYTHON OFF)

if(APPLE)
    byd__cmake__add_cmake_arg(${package} BUILD_TESTING OFF)
    byd__cmake__add(${package}
        SKIP test)
else()
    byd__cmake__add(${package})
endif()
