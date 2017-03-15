


include("${CMUT_ROOT}/utils/cmut__utils__parse_version.cmake")

include("${BYD_ROOT}/cmake/modules/byd__property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__add_package_to_build_list name)
    byd__add_to_property(__BYD__PACKAGE_TO_BUILD ${name})
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__define_version name version)

    set(BYD__${name}_VERSION ${version} CACHE STRING "${name} version to build")

    __byd__private__version_to_name(${BYD__${name}_VERSION} BYD__${name}_VERSION_NAME)

#    cmut__utils__parse_version(${version} BYD__${name}_VERSION_MAJOR
#                                          BYD__${name}_VERSION_MINOR
#                                          BYD__${name}_VERSION_PATCH)
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(byd__add_package name)

    set(BYD__${name} ON)
    __byd__add_package_to_build_list(${name})


    set(options "")
    set(oneValueArgs VERSION)
    set(multiValueArgs OPTIONS)
    cmake_parse_arguments(
        __BYD__ADD_PACKAGE
        "${options}" "${oneValueArgs}" "${multiValueArgs}"
        ${ARGN}
    )


    if(__BYD__ADD_PACKAGE_VERSION)
        __byd__define_version(${name} ${__BYD__ADD_PACKAGE_VERSION})
    endif()

    byd__set_property(BYD__EP__GENERAL__PREFIX__${name} ${name})
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
