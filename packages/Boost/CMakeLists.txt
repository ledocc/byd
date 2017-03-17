include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(CMAKE_INSTALL_PREFIX)

    if(byd__icu)
        byd__BoostBuild__build__add_args(${package} "-sICU_PATH=${CMAKE_INSTALL_PREFIX}")
    endif()

    if(byd__zlib)
        byd__BoostBuild__build__add_args(${package} "-sZLIB_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sZLIB_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sZLIB_BINARY=zdll")
        endif()
    endif()

    if(byd__bzip2)
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sBZIP2_BINARY=bz2")
        endif()
    endif()

endif()


byd__package__get_components_to_build(${package} BOOST_COMPONENTS_TO_BUILD)
foreach(lib ${BOOST_COMPONENTS_TO_BUILD})
    byd__BoostBuild__build__add_args(${package} "--with-${lib}")
endforeach()

byd__EP__compile_in_source(${package} ON)
byd__BoostBuild__add(${package})


#ExternalProject_Get_Property(Boost SOURCE_DIR)

#set(ENV{BOOST_BUILD_PATH} ${SOURCE_DIR})
#configure_file(user-config.jam.in ${SOURCE_DIR}/user-config.jam)
