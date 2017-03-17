


include("${BYD_ROOT}/cmake/modules/byd__property.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")



##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_version package version)

    cmut_debug("[byd][package] - [${package}] : add version : ${version}")
    __byd__private__version_to_name(${version} version_name)

    __byd__package__set_property(${version_name} "${ARGN}")
    byd__package__set_default_version("${package}" "${version}")

endfunction()

##---------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_version_info package version result)

    __byd__private__version_to_name(${version} version_name)

    __byd__package__get_property(${version_name} info)
    set(${result} "${info}" PARENT_SCOPE)

endfunction()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
