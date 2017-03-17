


include("${CMUT_ROOT}/utils/cmut__utils__parse_version.cmake")

include("${BYD_ROOT}/cmake/modules/byd__find_package_directory.cmake")
include("${BYD_ROOT}/cmake/modules/byd__prefix.cmake")
include("${BYD_ROOT}/cmake/modules/byd__property.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__is_build.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__add_package_to_build_list name)
    byd__add_to_property(__BYD__PACKAGE_TO_BUILD ${name})
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__add_package package)

    # parse arguments
    set(options "")
    set(oneValueArgs VERSION)
    set(multiValueArgs COMPONENTS)
    cmut__utils__parse_arguments(
        byd__add_package
        PARAM
        "${options}" "${oneValueArgs}" "${multiValueArgs}"
        ${ARGN}
        )



    # look for package directory
    byd__find_package_directory(${package} package_dir)
    cmut_debug("[byd] - [${package}] : use info from ${package_dir}.")


    # include package version file
    set(version_file "${package_dir}/version.cmake")
    if(NOT EXISTS "${version_file}")
        cmut_fatal("[byd] - [${package}] : ${version_file} not found.")
    endif()
    cmut_debug("[byd] - [${package}] : include ${package_dir}/version.cmake.")
    include("${package_dir}/version.cmake")


    # define version to build
    if(NOT PARAM_VERSION)
        byd__package__get_default_version(${package} PARAM_VERSION)
    endif()
    cmut_info("[byd] - [${package}] : version to build ${PARAM_VERSION}")
    byd__package__set_version_to_build(${package} "${PARAM_VERSION}")


    # define components to build
    if(PARAM_COMPONENTS)
        cmut_info("[byd] - [${package}] : component to build :")
        foreach(component IN LISTS PARAM_COMPONENTS)
            cmut_info(" - ${component}")
        endforeach()
        byd__package__set_components_to_build(${package} "${PARAM_COMPONENTS}")
    endif()


    # define prefix (where to download/configure/build)
    set(prefix "packages/${package}")
    byd__get_prefix(global_prefix)
    if(global_prefix)
        set(prefix "${global_prefix}/${prefix}")
    endif()
    byd__EP__set_package_arg(${package} GENERAL PREFIX "${prefix}")


    # add to build list
    byd__package__set_build(${package})
    __byd__add_package_to_build_list(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
