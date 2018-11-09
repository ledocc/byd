


include("${BYD_ROOT}/cmake/modules/byd__package_repositories.cmake")
include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__define_step_info.cmake")
include("${BYD_ROOT}/cmake/modules/option.cmake")

include("${CMUT_ROOT}/config/cmut__config__resolve_install_prefix.cmake")

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__set_initialized)
    byd__func__set_property(BYD__INITIALIZED 1)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__is_initialized result)
    byd__func__get_property(BYD__INITIALIZED initialized)
    byd__func__return(initialized)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__initialize_if_not_done)

    byd__is_initialized(initialized)
    if(NOT initialized)
        byd__initialize()
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__initialize)

    __byd__set_initialized()

    byd__add_fallback_package_repositories( "${BYD_ROOT}/packages" )


    byd__option__build_shared_libs()
    byd__option__build_testing()
    byd__option__jobs()
    byd__option__local_repo()
    byd__option__log_step()
    byd__option__prefix()
    byd__option__remote_repo()
    byd__option__upload_archive()
    byd__option__force_build()
    byd__option__use_ccache()


    byd__EP__set_default_argument(DOWNLOAD TIMEOUT 3600)

    byd__func__set_default(CMAKE_BUILD_TYPE Release)


    byd__variable__osx_sdk__define()
    byd__variable__compiler_compatible_id__define()


    if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
        set(CMAKE_INSTALL_PREFIX install CACHE PATH "Install path prefix, prepended onto install directories." FORCE)
    endif()

    if(CMAKE_INSTALL_PREFIX)
        cmut__config__resolve_install_prefix()
    endif()



    cmut_info("[byd] - ")
    cmut_info("[byd] - ")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - welcome to byd (Build Your Dependencies)")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - ")
    cmut_info("[byd] - ")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - Build informations :")
    cmut_info("[byd] - ")
    cmut_info("[byd] - BUILD_SHARED_LIBS    = ${BUILD_SHARED_LIBS}")
    cmut_info("[byd] - BUILD_TESTING        = ${BUILD_TESTING}")
    cmut_info("[byd] - CMAKE_BUILD_TYPE     = ${CMAKE_BUILD_TYPE}")
    cmut_info("[byd] - CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
    cmut_info("[byd] - ")
    cmut_info("[byd] - BYD__VARIABLE__C_COMPILER_COMPATIBLE_ID   = ${BYD__VARIABLE__C_COMPILER_COMPATIBLE_ID}")
    cmut_info("[byd] - BYD__VARIABLE__CXX_COMPILER_COMPATIBLE_ID = ${BYD__VARIABLE__CXX_COMPILER_COMPATIBLE_ID}")
    cmut_info("[byd] - ")
    cmut_info("[byd] - ")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - System informations :")
    cmut_info("[byd] - CMAKE_SYSTEM_NAME      = ${CMAKE_SYSTEM_NAME}")
    cmut_info("[byd] - CMAKE_SYSTEM_VERSION   = ${CMAKE_SYSTEM_VERSION}")
    cmut_info("[byd] - CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
    cmut_info("[byd] - CMAKE_SYSROOT          = ${CMAKE_SYSROOT}")
    cmut_info("[byd] - CMAKE_STAGING_PREFIX   = ${CMAKE_STAGING_PREFIX}")
    cmut_info("[byd] -")
    cmut_info("[byd] -")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - Toolchain informations :")
    if(ANDROID)
    cmut_info("[byd] -")
        cmut_info("[byd] - CMAKE_ANDROID_API = ${CMAKE_ANDROID_API}")
        cmut_info("[byd] - CMAKE_ANDROID_ARCH_ABI = ${CMAKE_ANDROID_ARCH_ABI}")
        cmut_info("[byd] - CMAKE_ANDROID_NDK = ${CMAKE_ANDROID_NDK}")
        cmut_info("[byd] - CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION = ${CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION}")
        cmut_info("[byd] - CMAKE_ANDROID_STL_TYPE = ${CMAKE_ANDROID_STL_TYPE}")
    endif()
    cmut_info("[byd] -")
    cmut_info("[byd] - CMAKE_GENERATOR_TOOLSET   = ${CMAKE_GENERATOR_TOOLSET}")
    cmut_info("[byd] - CMAKE_GENERATOR_PLATEFORM = ${CMAKE_GENERATOR_PLATFORM}")
    foreach(lang C CXX)
        cmut_info("[byd] -")
        cmut_info("[byd] - CMAKE_${lang}_COMPILER        = ${CMAKE_${lang}_COMPILER}")
        cmut_info("[byd] - CMAKE_${lang}_COMPILER_TARGET = ${CMAKE_${lang}_COMPILER_TARGET}")
        cmut_info("[byd] - CMAKE_${lang}_COMPILER_EXTERNAL_TOOLCHAIN = ${CMAKE_${lang}_COMPILER_EXTERNAL_TOOLCHAIN}")
        if(ANDROID)
            cmut_info("[byd] - CMAKE_${lang}_ANDROID_TOOLCHAIN_PREFIX = ${CMAKE_${lang}_ANDROID_TOOLCHAIN_PREFIX}")
            cmut_info("[byd] - CMAKE_${lang}_ANDROID_TOOLCHAIN_SUFFIX = ${CMAKE_${lang}_ANDROID_TOOLCHAIN_SUFFIX}")
        endif()
    endforeach()
    cmut_info("[byd] -")
    cmut_info("[byd] -")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - ----------------------------------------")
    cmut_info("[byd] - ----------------------------------------")



    byd__EP__define_step_info()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
