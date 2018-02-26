


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

macro(__byd__add_package_to_build_list name version)

    byd__func__get_property(__BYD__PACKAGE_TO_BUILD package_to_build)
    if(NOT "${name}" IN_LIST package_to_build)
        byd__func__add_to_property(__BYD__PACKAGE_TO_BUILD ${name})
        cmut_info("[byd] - add \"${name}\" ${version} to build list.")
    endif()
endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(byd__add_package__include_id_file id_file)

    if(NOT EXISTS "${id_file}")
        cmut_fatal("[byd] - [${package}] : ${id_file} not found.")
    endif()
    cmut_debug("[byd] - [${package}] : include ${id_file}.")
    include("${id_file}")

endmacro()

macro(byd__add_package__include_component_file component_file)

    if(EXISTS "${component_file}")
        cmut_debug("[byd] - [${package}] : include ${component_file}.")
        include("${component_file}")
    endif()

endmacro()


function(byd__add_package package)

    byd__package__assert_no_component(${package} byd__add_package)


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

    # include package's id
    byd__func__get_property(BYD__ADD_PACKAGE__${package}_INFO_INCLUDED is_package_added)
    if(NOT is_package_added)

        byd__private__find_package_directory(${package} package_dir)
        cmut_info("[byd] - [${package}] : use info from ${package_dir}.")

        byd__add_package__include_id_file("${package_dir}/id.cmake")
        byd__add_package__include_component_file("${package_dir}/component.cmake")
        byd__func__set_property(BYD__ADD_PACKAGE__${package}_INFO_INCLUDED 1)

        # define prefix (where to download/configure/build)
        set(prefix "packages/${package}")
        byd__get_prefix(global_prefix)
        if(global_prefix)
            set(prefix "${global_prefix}/${prefix}")
        endif()
        byd__EP__set_package_argument(${package} GENERAL PREFIX "${prefix}")

    endif()

    byd__package__get_components(${package} available_components)
    if(PARAM_COMPONENTS)
        if(available_components STREQUAL "")
            unset(PARAM_COMPONENTS)
        endif()
    else()
        if(NOT available_components STREQUAL "")
            set(PARAM_COMPONENTS ${available_components})
        endif()
    endif()


    if(PARAM_COMPONENTS)
        byd__add_package__add_component(${package} "${PARAM_COMPONENTS}")
    else()
        byd__add_package__apply(${package})
    endif()

endfunction()

function(byd__add_package__add_component package components_to_add)

    foreach(component_or_module IN LISTS components_to_add)
        byd__package__convert_module_to_component_if_need(${package} ${component_or_module} component)
        if(NOT "${component}" STREQUAL "")
            list(APPEND components ${component})
        endif()
    endforeach()

    list(REMOVE_DUPLICATES components)

    foreach(component IN LISTS components)
        byd__package__make_package_component_name(${package} ${component} package_component_name)
        byd__add_package__apply(${package_component_name})
    endforeach()

endfunction()

function(byd__add_package__apply package)
    byd__package__set_added(${package})

    byd__package__get_version(${package} version)
    __byd__add_package_to_build_list(${package} ${version})
endfunction()





##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
