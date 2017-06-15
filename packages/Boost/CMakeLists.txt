include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(CMAKE_INSTALL_PREFIX)

    # use icu if built by byd
    byd__package__is_added(icu icu_added)
    if(icu_added)
        byd__BoostBuild__build__add_args(${package} "-sICU_PATH=${CMAKE_INSTALL_PREFIX}")
    endif()


    # use zlib if built by byd
    byd__package__is_added(zlib zlib_added)
    if(zlib_added)
        byd__BoostBuild__build__add_args(${package} "-sZLIB_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sZLIB_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sZLIB_BINARY=zdll")
        endif()
    endif()


    # use bzip2 if built by byd
    byd__package__is_added(bzip2 bzip2_added)
    if(bzip2_added)
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sBZIP2_BINARY=bz2")
        endif()
    endif()

endif()



# define comoponent to build
byd__package__get_components_to_build(${package} BOOST_COMPONENTS_TO_BUILD)
foreach(lib ${BOOST_COMPONENTS_TO_BUILD})
    byd__BoostBuild__build__add_args(${package} "--with-${lib}")
endforeach()



# configure boost.locale build
if("locale" IN_LIST BOOST_COMPONENTS_TO_BUILD)
    byd__BoostBuild__build__add_args(${package} "boost.locale.icu=on")
    byd__BoostBuild__build__add_args(${package} "boost.locale.std=off")
    if(WIN32)
        byd__BoostBuild__build__add_args(${package} "boost.locale.winapi=off")
    elseif(UNIX)
        byd__BoostBuild__build__add_args(${package} "boost.locale.iconv=off")
        byd__BoostBuild__build__add_args(${package} "boost.locale.posix=off")
    endif()
endif()



# compile Boost in source
byd__EP__compile_in_source(${package} ON)



# add custom_patch step
byd__package__get_version_to_build(${package} version_to_build)
set(VERSION_DIR "${CMAKE_CURRENT_LIST_DIR}/${version_to_build}")

file(GLOB patchList
    LIST_DIRECTORIES false
    "${VERSION_DIR}/patch/*.patch"
    )
byd__custom_patch(${package} patchList)


# add BoostBuild step
byd__BoostBuild__add(${package})
