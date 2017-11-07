


include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")

include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_dependency package)

    __byd__package__set_property(DEPENDENCY "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_dependency package)

    __byd__package__add_to_property(DEPENDENCY "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_dependency package result)

    __byd__package__get_property(DEPENDENCY dependency)
    byd__func__return(dependency)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


function(byd__package__set_component_dependencies package)

    cmut__utils__parse_arguments(byd__package__add_dependency
        PARAM
        ""
        "COMPONENT"
        "DEPENDS"
        ${ARGN}
        )

    if(NOT PARAM_COMPONENT)
        return()
    endif()

    if(NOT PARAM_DEPENDS)
        return()
    endif()

    __byd__package__set_property(DEPENDENCIES__${PARAM_COMPONENT} "${PARAM_DEPENDS}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_component_dependencies package component result)

    __byd__package__get_property(DEPENDENCIES__${component} dependency)
    byd__func__return(dependency)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


function(byd__package__collect_dependencies package result)

    byd__package__get_dependency(${package} dependencies)

    byd__package__get_components_to_build(${package} components)
    foreach(component IN LISTS components)
        byd__package__get_component_dependencies(${package} ${component} per_component_dependencies)
        list(APPEND dependencies ${per_component_dependencies})
    endforeach()

    list(SORT dependencies)
    list(REMOVE_DUPLICATES dependencies)

    byd__func__return(dependencies)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


function(byd__package__include_dependency_file package)

    byd__private__find_package_directory(${package} package_dir)

    set(__dependency_file "${package_dir}/dependency.cmake")
    if (EXISTS "${__dependency_file}")
        cmut_debug("[byd] - [${package}] : include ${__dependency_file}.")
        include("${__dependency_file}")
    else()
        cmut_debug("[byd] - [${package}] : ${__dependency_file} not found.")
        cmut_info("[byd] - [${package}] : not dependency for \"${package}\".")
    endif()

endfunction()



function(byd__package__collect_dependencies_abis package result)

    byd__package__collect_dependencies(${package} dependencies)

    set(abis)
    foreach(dependency IN LISTS dependencies)
        byd__package__get_abi(${dependency} abi)
        list(APPEND abis ${abi})
    endforeach()

    byd__func__return(abis)

endfunction()
