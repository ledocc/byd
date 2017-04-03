include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(CMAKE_INSTALL_PREFIX)

    byd__package__is_added(icu icu_added)
    if(icu_added)
        byd__BoostBuild__build__add_args(${package} "-sICU_PATH=${CMAKE_INSTALL_PREFIX}")
    endif()

    byd__package__is_added(zlib zlib_added)
    if(zlib_added)
        byd__BoostBuild__build__add_args(${package} "-sZLIB_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sZLIB_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sZLIB_BINARY=zdll")
        endif()
    endif()

    byd__package__is_added(bzip2 bzip2_added)
    if(bzip2_added)
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


byd__EP__compile_in_source(${package} ON)
byd__BoostBuild__add(${package})



byd__package__get_version_to_build(${package} version_to_build)
set(VERSION_DIR "${CMAKE_CURRENT_LIST_DIR}/${version_to_build}")
byd__package__get_source_dir(${package} source_dir)

ExternalProject_Add_Step(
    ${package}
    custom_patch
    COMMAND git apply --ignore-whitespace "${VERSION_DIR}/patch/boost_icu_msvc.patch"
    DEPENDEES update
    DEPENDERS configure
    WORKING_DIRECTORY ${source_dir}
    )