include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(NOT DEFINED BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ON)
endif()

set(BUILD_STATIC_LIBS ON)
if(BUILD_SHARED_LIBS)
    set(BUILD_STATIC_LIBS OFF)
endif()

byd__cmake__configure__add_arg(${package} PNG_SHARED ${BUILD_SHARED_LIBS})
byd__cmake__configure__add_arg(${package} PNG_STATIC ${BUILD_STATIC_LIBS})

byd__cmake__add(${package})
