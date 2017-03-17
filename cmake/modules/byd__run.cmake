


include("${BYD_ROOT}/cmake/modules/byd__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__include_package_dependency name)

    byd__find_package_directory(${package} package_dir)

    set(__dependency_file "${package_dir}/dependency.cmake")
    if (EXISTS "${__dependency_file}")
        cmut_debug("[byd] - [${package}] : include ${__dependency_file}.")
        include("${__dependency_file}")
    else()
        cmut_debug("[byd] - [${package}] : ${__dependency_file} not found.")
        cmut_info("[byd] - [${package}] : not dependency for \"${package}\".")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__build_package_dependency package)

    __byd__include_package_dependency(${package})

    byd__package__get_dependency(${package} dependencies)
    if(NOT dependencies)
        return()
    endif()


    cmut_info("[byd] - [${package}] : dependency list :")
    foreach(dependency IN LISTS dependencies)
        cmut_info("[byd] - [${package}] : - ${dependency} :")
    endforeach()


    foreach(dependency IN LISTS dependencies)
        byd__package__is_build(${dependency} is_build)
        if(NOT is_build)
            byd__add_package(${dependency})
        endif()

        __byd__build_package(${dependency})
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__check_loop_dependency package)

    byd__get_property(__BYD__BUILD_PACKAGE_STACK build_package_stack)

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

function(__byd__check_already_build package result)

    byd__get_property("__BYD__BUILD_PACKAGE_DONE_LIST" build_package_done_list)

    if(${package} IN_LIST build_package_done_list)
        set(${result} ON PARENT_SCOPE)
    else()
        set(${result} OFF PARENT_SCOPE)
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__mark_as_done package)
    byd__add_to_property("__BYD__BUILD_PACKAGE_DONE_LIST" ${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__push_to_build_stack package)
    byd__add_to_property("__BYD__BUILD_PACKAGE_STACK" ${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__pop_from_build_stack package)
    byd__remove_from_property("__BYD__BUILD_PACKAGE_STACK" ${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__build_package package)


    byd__find_package_directory(${package} package_dir)


    __byd__check_loop_dependency(${package})

    __byd__check_already_build(${package} already_build)
    if(already_build)
        return()
    endif()

    cmut_info("[byd] - [${package}] : begin build.")

    __byd__push_to_build_stack(${package})

        __byd__build_package_dependency(${package})

        cmut_debug("[byd] - [${package}] : include CMakeLists.txt")
        include("${package_dir}/CMakeLists.txt")

        __byd__mark_as_done(${package})

    __byd__pop_from_build_stack(${package})

    cmut_info("[byd] - [${package}] : end build.")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__run)

    byd__set_property("__BYD__BUILD_PACKAGE_STACK" "")
    byd__set_property("__BYD__BUILD_PACKAGE_DONE_LIST" "")

    byd__get_property(__BYD__PACKAGE_TO_BUILD packages)

    foreach(package IN LISTS packages)
        __byd__build_package(${package})
    endforeach()

endfunction()
