include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(MSVC)
    byd__cmake__add(${package})
else()
    byd__autotool__add(${package})
endif()
