
include("${CMAKE_CURRENT_LIST_DIR}/_unix.cmake")

cmut_EP_add_config_arg(-no-icu)

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    cmut_EP_add_config_arg(-no-framework)
else()
    cmut_EP_add_config_arg(-framework)
endif()

cmut_EP_add_config_arg(-securetransport)

if(CMAKE_OSX_SYSROOT)

    # workaround : cmake 3.5.2 convert CMAKE_OSX_SYSROOT short name to SDK path
    # retrieve short name from path
    get_filename_component(SDKROOT_FOR_${module} ${CMAKE_OSX_SYSROOT} NAME)
    string(TOLOWER ${SDKROOT_FOR_${module}} SDKROOT_FOR_${module})
    string(REGEX MATCH "[a-z]+[0-9]+\.[0-9]+" SDKROOT_FOR_${module} ${SDKROOT_FOR_${module}})

    cmut_EP_add_config_arg(-sdk ${SDKROOT_FOR_${module}})
endif()
