



include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")

include("${BYD_ROOT}/cmake/modules/byd__initialize.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


function(__byd__include_package_dependency_file package)

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

function(__byd__collect_package_dependencies package result)

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

function(__byd__build_package_dependency package)

    __byd__include_package_dependency_file(${package})
    __byd__collect_package_dependencies(${package} dependencies)
    if(NOT dependencies)
        return()
    endif()


    cmut_info("[byd] - [${package}] : dependency list :")
    foreach(dependency IN LISTS dependencies)
        cmut_info("[byd] - [${package}] : - ${dependency} :")
    endforeach()


    foreach(dependency IN LISTS dependencies)
        byd__add_package(${dependency})
        __byd__build_package(${dependency})
    endforeach()

    byd__EP__set_package_argument(${package} GENERAL DEPENDS "${dependencies}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__check_loop_dependency package)

    byd__func__get_property(__BYD__BUILD_PACKAGE_STACK build_package_stack)

    if(${package} IN_LIST build_package_stack)

        cmut_info("[byd] : loop dependency detected.")
        cmut_info("[byd] : stack : ")
        foreach(package IN LISTS build_package_stack)
            cmut_info("[byd] : - ${package}")
        endforeach()
        cmut_fatal("[byd] : loop dependency detected !!!")

    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__push_to_build_stack package)
    byd__func__add_to_property("__BYD__BUILD_PACKAGE_STACK" ${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__pop_from_build_stack package)
    byd__func__remove_from_property("__BYD__BUILD_PACKAGE_STACK" ${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__build_package package)


    byd__private__find_package_directory(${package} package_dir)


    __byd__check_loop_dependency(${package})

    byd__private__is_package_generated(${package} already_generated)
    if(already_generated)
        cmut_debug("[byd] - [${package}] : already generated. skip.")
        return()
    endif()


    cmut_info("[byd] - [${package}] : begin of generation.")

    __byd__push_to_build_stack(${package})

        __byd__build_package_dependency(${package})

        cmut_debug("[byd] - [${package}] : include CMakeLists.txt")
        include("${package_dir}/CMakeLists.txt")

        byd__private__set_package_generated(${package})

    __byd__pop_from_build_stack(${package})

    cmut_info("[byd] - [${package}] : end of generation.")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__filesystem__absolute path base result)

    if((path) AND (NOT IS_ABSOLUTE "${path}"))
        set(absolute_path "${base}/${path}")
    else()
        set(absolute_path "${path}")
    endif()
    byd__func__return(absolute_path)

endfunction()


function(byd__func__set_default variable default_value)
    if((NOT DEFINED ${variable}) OR ("x${${variable}}" STREQUAL "x"))
        set(${variable} ${default_value} PARENT_SCOPE)
    endif()
endfunction()

function(byd__run)

    byd__initialize_if_not_done()

    cmut_info("[byd] -")
    cmut_info("[byd] -")
    cmut_info("[byd] - --------------------------------")
    cmut_info("[byd] - start ExternalProject generation")
    cmut_info("[byd] - --------------------------------")
    cmut_info("[byd] -")
    cmut_info("[byd] -")


    byd__func__set_property("__BYD__BUILD_PACKAGE_STACK" "")

    byd__func__get_property(__BYD__PACKAGE_TO_BUILD packages)
    foreach(package IN LISTS packages)
        __byd__build_package(${package})
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
