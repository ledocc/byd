
include("${BYD_ROOT}/cmake/modules/byd__property.cmake")



macro(__byd__include_package_dependencies name)

    set(__dependencies_file "${BYD_ROOT}/packages/${name}/dependencies.cmake")

    if (EXISTS "${__dependencies_file}")
        cmut_debug("${name} dependencies file : ${__dependencies_file} found")
        cmut_info("include ${name} dependencies file")
        include("${__dependencies_file}")
    else()
        cmut_debug("${name} dependencies file \"${__dependencies_file}\" not found")
    endif()

endmacro()


function(__byd__is_dependencies_defined name result)
    byd__is_property(BYD__${name}_DEPENDENCIES __result)
    set(${result} ${__result} PARENT_SCOPE)
endfunction()


function(__byd__make_depends name)

    cmut_debug("__byd__make_depends(${name}) -- begin")

    __byd__is_dependencies_defined(${name} has_dependencies)
    if(NOT has_dependencies)
        cmut_debug("byd__make_depends : no dependencies defined for ${name}")
        cmut_debug("byd__make_depends(${name}) -- end")
        return()
    endif()

    byd__get_property(BYD__${name}_DEPENDENCIES dependencies)

    foreach(dependency ${dependencies})
        if(DEFINED BYD__${dependency})
            if(BYD__${dependency})
                cmut_debug("byd__make_depends : add dependency \"${dependency}\"")
                list(APPEND __depends ${dependency})
            else()
                cmut_debug("byd__make_depends : dependency \"${dependency}\" disable. skip.")
            endif()
        else()
            cmut_debug("byd__make_depends : dependency \"${dependency}\" not defined")
        endif()
    endforeach()


    set(BYD__${name}_DEPENDS ${__depends} PARENT_SCOPE)

    cmut_debug("__byd__make_depends(${name}) -- end")

endfunction()


macro(__byd__build_package_dependencies name)

    __byd__make_depends(${name})

    foreach(package ${BYD__${name}_DEPENDS})
        __byd__build_package(${package})
    endforeach()

endmacro()



macro(__byd__build_package name)


    cmut_debug("__byd__build_package(${name})")

    # check loop dependency
    byd__get_property("__BYD__BUILD_PACKAGE_STACK" build_package_stack)
    if(${name} IN_LIST build_package_stack)
        cmut_info("__byd__build_package : loop dependency detected.\n"
                  "stack : ")
        foreach(package ${build_package_stack})
            cmut_info(${package})
        endforeach()
        cmut_error("loop dependency detected !!! ")
    endif()


    # if already done, return
    byd__get_property("__BYD__BUILD_PACKAGE_DONE_LIST" build_package_done_list)
    if(${name} IN_LIST build_package_done_list)
        cmut_debug("__byd__build_package : ${name} already done")
        return()
    endif()


    # add to build_stack
    byd__add_to_property("__BYD__BUILD_PACKAGE_STACK" ${name})
    cmut_debug("__byd__build_package : build_package_stack ${__byd__build_package_stack}")

    if(NOT BYD__${package})
        cmut_info("__byd__build_package : package ${name} not defined (skipped).")
        return()
    endif()


    # load and add dependencies
    __byd__include_package_dependencies(${name})
    __byd__build_package_dependencies(${name})

    # add package
    cmut_info("add package \"${name}\"")
    include("${BYD_ROOT}/cmake/packages/${name}/CMakeLists.txt")

    # mark as done
    byd__add_to_property("__BYD__BUILD_PACKAGE_LIST_DONE" ${name})
    cmut_debug("__byd__build_package : build_package_done_list ${__byd__build_package_done_list}")

    # remove from build_stack
    byd__remove_from_property("__BYD__BUILD_PACKAGE_STACK" ${name})
    cmut_debug("__byd__build_package : build_package_stack ${__byd__build_package_stack}")


    cmut_debug("__byd__build_package(${name}) done")

endmacro()




function(byd__run)

    byd__set_property("__BYD__BUILD_PACKAGE_STACK" "")
    byd__set_property("__BYD__BUILD_PACKAGE_LIST_DONE" "")

    byd__get_property(__BYD__PACKAGE_TO_BUILD packages)

    foreach(package ${packages})
        __byd__build_package(${package})
    endforeach()

endfunction()
