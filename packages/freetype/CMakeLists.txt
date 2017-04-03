include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(UNIX)
    byd__autotool__configure__add_args(${package} "-with-bzip2=no")
    byd__autotool__add(${package} SKIP test)
else()
    if(NOT MINGW)
        set(BUILD_SHARED_LIBS OFF)
    endif() 
    byd__cmake__add(${package} SKIP test)
endif()
