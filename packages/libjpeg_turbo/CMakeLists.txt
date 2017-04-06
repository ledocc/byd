include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


byd__package__get_version_to_build(${package} version_to_build)

if(version_to_build VERSION_LESS 1.6)
    if(MSVC)
        byd__cmake__add(${package})
    else()
        byd__autotool__add(${package})
    endif()
else()
    byd__cmake__add(${package})
endif()
