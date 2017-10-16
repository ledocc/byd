


include("${CMUT_ROOT}/utils/cmut__utils__parse_version.cmake")

include("${BYD_ROOT}/cmake/modules/byd__prefix.cmake")
include("${BYD_ROOT}/cmake/modules/byd__initialize.cmake")
include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/EP.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__add_package_to_build_list name)
    byd__func__add_to_property(__BYD__PACKAGE_TO_BUILD ${name})
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__add_package package)

    byd__initialize_if_not_done()


    # parse arguments
    cmut__utils__parse_arguments(
        byd__add_package
        PARAM
        ""
        ""
        "COMPONENTS"
        ${ARGN}
        )

    cmut_info("[byd] - ")
    cmut_info("[byd] - ---------------------------------")
    cmut_info("[byd] - add \"${package}\" to build list.")



    # look for package directory
    byd__private__find_package_directory(${package} package_dir)
    cmut_info("[byd] - [${package}] : use info from ${package_dir}.")


    # include package id file
    set(id_file "${package_dir}/id.cmake")
    if(NOT EXISTS "${id_file}")
        cmut_fatal("[byd] - [${package}] : ${id_file} not found.")
    endif()
    cmut_debug("[byd] - [${package}] : include ${id_file}.")
    include("${id_file}")

    byd__package__get_version(${package} version)
    cmut_info("[byd] - [${package}] : version : ${version}.")


    # include package component file
    set(component_file "${package_dir}/component.cmake")
    if(EXISTS "${component_file}")
        cmut_debug("[byd] - [${package}] : include ${component_file}.")
        include("${component_file}")
    endif()

    # define components to build
    if(PARAM_COMPONENTS)
        cmut_info("[byd] - [${package}] : component to build :")
        foreach(component IN LISTS PARAM_COMPONENTS)
            cmut_info("[byd] - [${package}] : - ${component}")
        endforeach()
        byd__package__add_components_to_build(${package} "${PARAM_COMPONENTS}")
    endif()

    cmut_info("[byd] - ---------------------------------")


    # define prefix (where to download/configure/build)
    set(prefix "packages/${package}")
    byd__get_prefix(global_prefix)
    if(global_prefix)
        set(prefix "${global_prefix}/${prefix}")
    endif()
    byd__EP__set_package_argument(${package} GENERAL PREFIX "${prefix}")


    # add to build list
    byd__private__set_package_added(${package})
    __byd__add_package_to_build_list(${package})


endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
