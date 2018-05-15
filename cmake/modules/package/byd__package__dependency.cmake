


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

    __byd__package__add_unique_to_property(DEPENDENCY "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_dependency package result)

    __byd__package__get_property(DEPENDENCY dependency)
    byd__func__return(dependency)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__component_dependencies__parse_argument package package_component_name dependencies)

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

    byd__package__make_package_component_name(${package} ${PARAM_COMPONENT} package)

    set(${package_component_name} "${package}" PARENT_SCOPE)
    set(${dependencies} "${PARAM_DEPENDS}" PARENT_SCOPE)

endfunction()


function(byd__package__set_component_dependencies package)

    byd__package__component_dependencies__parse_argument(${package} package dependencies ${ARGN})

    if(NOT dependencies)
        return()
    endif()

    __byd__package__set_property(DEPENDENCY "${dependencies}")

endfunction()

function(byd__package__add_component_dependencies package)

    byd__package__component_dependencies__parse_argument(${package} package dependencies ${ARGN})

    if(NOT dependencies)
        return()
    endif()

    __byd__package__add_unique_to_property(DEPENDENCY "${dependencies}")

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

    byd__package__get_dependency(${package} dependencies)

    set(abis)
    foreach(dependency IN LISTS dependencies)
        byd__package__get_abi(${dependency} abi)
        list(APPEND abis "${dependency}=${abi}")
    endforeach()

    byd__func__return(abis)

endfunction()
