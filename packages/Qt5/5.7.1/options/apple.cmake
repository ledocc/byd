
include("${CMAKE_CURRENT_LIST_DIR}/_unix.cmake")


byd__Qt5__configure__add_args(${package} -no-icu)

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    byd__Qt5__configure__add_args(${package} -no-framework)
else()
    byd__Qt5__configure__add_args(${package} -framework)
endif()

byd__Qt5__configure__add_args(${package} -securetransport)



if(CMAKE_OSX_SYSROOT)

    # workaround : cmake 3.5.2 convert CMAKE_OSX_SYSROOT short name to SDK path
    # retrieve short name from path
    get_filename_component(SDKROOT_FOR_${module} ${CMAKE_OSX_SYSROOT} NAME)
    string(TOLOWER ${SDKROOT_FOR_${module}} SDKROOT_FOR_${module})
    string(REGEX MATCH "[a-z]+[0-9]+\.[0-9]+" SDKROOT_FOR_${module} ${SDKROOT_FOR_${module}})

    byd__Qt5__configure__add_args(${package} -sdk ${SDKROOT_FOR_${module}})

endif()
