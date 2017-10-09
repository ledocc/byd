



include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")

include("${BYD_ROOT}/cmake/modules/byd__initialize.cmake")

include("${BYD_ROOT}/cmake/modules/action.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__build_package_dependency package)

    byd__package__include_dependency_file(${package})
    byd__package__collect_dependencies(${package} dependencies)
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


        byd__private__is_package_archive_available(${package} archive_available)
        if(archive_available)
            cmut_debug("[byd] - [${package}] : archive available.")
            byd__action__extract_archive(${package})
            byd__empty__add(${package})
        else()
            set(CMAKE_INSTALL_PREFIX_SAVE ${CMAKE_INSTALL_PREFIX})
            set(CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${package})
            cmut_debug("[byd] - [${package}] : include CMakeLists.txt")
            byd__action__create_archive(${package})
            include("${package_dir}/CMakeLists.txt")
            set(CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX_SAVE})
        endif()

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

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__set_default variable default_value)
    if((NOT DEFINED ${variable}) OR ("x${${variable}}" STREQUAL "x"))
        set(${variable} ${default_value} PARENT_SCOPE)
    endif()
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

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
    list(REMOVE_DUPLICATES packages)

    foreach(package IN LISTS packages)
        __byd__build_package(${package})
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__generate_and_build source_dir)

    cmut_info("build dir = ${CMAKE_BINARY_DIR}/byd/_build")

    execute_process(COMMAND ${CMAKE_COMMAND} ${source_dir}
                    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/byd")
    execute_process(COMMAND ${CMAKE_COMMAND} --build . -- -j1
                    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/byd")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
