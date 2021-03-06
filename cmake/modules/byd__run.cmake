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
    byd__package__get_dependency(${package} dependencies)
    if(NOT dependencies)
        return()
    endif()


    cmut_info("[byd] - [${package}] : dependency list :")
    foreach(dependency IN LISTS dependencies)
        cmut_info("[byd] - [${package}] : - ${dependency} :")
    endforeach()


    foreach(dependency IN LISTS dependencies)
        byd__package__split_package_component_name("${dependency}" package_name component_name)
        byd__private__is_empty("${component_name}" is_component_name_empty)

        set(opts)
        if(NOT is_component_name_empty)
            set(opts COMPONENTS ${component_name})
        endif()

        byd__add_package(${package_name} ${opts})

        byd__build_package(${dependency})
    endforeach()

    byd__EP__set_package_argument(${package} GENERAL DEPENDS "${dependencies}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__check_loop_dependency package)

    byd__func__get_property(__BYD__BUILD_PACKAGE_STACK build_package_stack)

    if(${package} IN_LIST build_package_stack)

        cmut_info("[byd] : loop dependency detected.")
        cmut_info("[byd] : package \"${package}\" already in stack.")
        cmut_info("[byd] : stack : ")
        foreach(package IN LISTS build_package_stack)
            cmut_info("[byd] : - ${package}")
        endforeach()
        cmut_info("[byd] : loop dependency detected !!!")
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

function(__byd__is_in_always_exception result package always_exception)

    set(in_list FALSE)
    if("${package}" IN_LIST always_exception)
        set(in_list TRUE)
    else()
        byd__package__get_package_name(${package} package_name)
        if("${package_name}" IN_LIST always_exception)
            set(in_list TRUE)
        endif()
    endif()

    byd__func__return(in_list)

endfunction()

function(byd__build_package package)

    cmut__utils__parse_arguments(
        byd__build_package
        ARG
        ""
        "BUILD_DIRECTIVE"
        "BUILD_DIRECTIVE_NEVER_EXCEPTION;BUILD_DIRECTIVE_ALWAYS_EXCEPTION"
        ${ARGN}
        )


    __byd__check_loop_dependency(${package})

    byd__package__is_generated(${package} already_generated)
    if(already_generated)
        cmut_debug("[byd] - [${package}] : already generated. skip.")
        return()
    endif()


    cmut_info("[byd] - [${package}] : begin of generation.")

    __byd__push_to_build_stack(${package})

        __byd__build_package_dependency(${package})


        byd__archive__remove_previous_build_if_byd_tag_not_match(${package})

        byd__private__is_package_archive_available(${package} archive_available)
        byd__package__is_force_build(force_build ${package})
        __byd__is_in_always_exception(is_in_always_exception ${package} "${ARG_BUILD_DIRECTIVE_ALWAYS_EXCEPTION}")
        if(     ( ( NOT "${ARG_BUILD_DIRECTIVE}" STREQUAL "ALWAYS") OR is_in_always_exception )
            AND archive_available
            AND ( NOT force_build )
            )
            cmut_debug("[byd] - [${package}] : archive available.")
            if (BYD__OPTION__UPLOAD_ARCHIVE)
                byd__action__upload_archive(${package})
            endif()
            byd__build_system__archive__add(${package})
        else()
            if("${ARG_BUILD_DIRECTIVE}" STREQUAL "NEVER")
                byd__package__get_package_name(${package} package_name)
                if( NOT "${package_name}" IN_LIST ARG_BUILD_DIRECTIVE_NEVER_EXCEPTION )
                    cmut_error("[byd][${package}] - BUILD_DIRECTIVE set to \"NEVER\" and no pre-build package \"${package}\" is available.")
                endif()
            elseif( ( "${ARG_BUILD_DIRECTIVE}" STREQUAL "ALWAYS" ) AND  is_in_always_exception )
                cmut_error("[byd][${package}] - BUILD_DIRECTIVE set to \"ALWAYS\" but package \"${package}\" is in list of BUILD_DIRECTIVE_ALWAYS_EXCEPTION, and no pre-build package is available.")
            endif()

            cmut_debug("[byd] - [${package}] : include CMakeLists.txt")
            byd__package__apply_download_info(${package})
            byd__action__extract_archive(${package})
            byd__action__create_archive(${package})
            if (BYD__OPTION__UPLOAD_ARCHIVE)
                byd__action__upload_archive(${package})
            endif()

            byd__private__find_package_directory(${package} package_dir)
            add_subdirectory("${package_dir}" "packages_subdirectory/${package}")
        endif()

        byd__archive__add_byd_tag(${package})


        byd__package__set_generated(${package})

    __byd__pop_from_build_stack(${package})

    cmut_info("[byd] - [${package}] : end of generation.")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__run)

    cmut__utils__parse_arguments(
        byd__run
        ARG
        ""
        "BUILD_DIRECTIVE"
        "BUILD_DIRECTIVE_NEVER_EXCEPTION;BUILD_DIRECTIVE_ALWAYS_EXCEPTION"
        ${ARGN}
        )

    set(allowed_build_directive "NEVER;REQUIRED;ALWAYS")
    if( ARG_BUILD_DIRECTIVE AND ( NOT ARG_BUILD_DIRECTIVE IN_LIST allowed_build_directive ) )
        cmut_fatal("[byd] - BUILD_DIRECTIVE should be one of ${allowed_build_directive}")
    endif()


    byd__initialize_if_not_done()

    cmut_info("[byd] -")
    cmut_info("[byd] -")
    cmut_info("[byd] - --------------------------------")
    cmut_info("[byd] - start ExternalProject generation")
    cmut_info("[byd] - --------------------------------")
    cmut_info("[byd] -")
    cmut_info("[byd] -")


    byd__func__set_property(__BYD__BUILD_PACKAGE_STACK "")

    byd__func__get_property(__BYD__PACKAGE_TO_BUILD packages)
    list(REMOVE_DUPLICATES packages)


    foreach(package IN LISTS packages)
        byd__build_package(${package} ${ARGN})
    endforeach()


    byd__archive__write_cmake_args_in_build_id()


    byd__archive__is_byd_tag_mismatch(byd_tag_mismatch)
    if(byd_tag_mismatch)

        cmut_info("[byd] - At least one byd tag mismatch")
        cmut_info("[byd] - remove ${CMAKE_INSTALL_PREFIX}")
        cmut__utils__rmdir(${CMAKE_INSTALL_PREFIX})

        byd__package__get_generated_list(package_generated)
        foreach(package IN LISTS package_generated)
            byd__action__extract_archive__reset(${package})
        endforeach()

    endif()

    byd__package__get_generated_list(package_generated)
    file(WRITE "${CMAKE_BINARY_DIR}/target.list" "${package_generated}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
