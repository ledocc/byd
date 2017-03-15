if(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
set(${CMAKE_CURRENT_LIST_FILE}_include "1")

include(cmut_define_num_core_available)
include("${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__parse_version.cmake")



cmake_policy(VERSION 3.7.2)

include(CMakePrintHelpers)
include(cmut_message)


set(__CMUT_EP_TO_BUILD_PREFIX CMUT_EP_)


macro(__cmut_EP_include_module_dependencies name)

    set(__dependencies_file ${PROJECT_SOURCE_DIR}/${CMUT_MODULE_PREFIX}/${name}/dependencies.cmake)

    if (EXISTS ${__dependencies_file})
        cmut_debug("${name} dependencies file : ${__dependencies_file} found")
        cmut_info("include ${name} dependencies file")
        include(${__dependencies_file})
    else()
        cmut_debug("${name} dependencies file \"${__dependencies_file}\" not found")
    endif()

endmacro()



macro(__cmut_EP_build_module name)

    cmut_debug("__cmut_EP_build_module(${name})")

    # check loop dependency
    if(${name} IN_LIST __cmut_EP_build_module_stack)
        cmut_info("__cmut_EP_build_module : loop dependency detected.\n"
                  "stack : ")
        foreach(module ${__cmut_EP_build_module_stack})
            cmut_info(${module})
        endforeach()
        message(FATAL_ERROR "loop dependency detected !!! ")
    endif()


    # if already done, return
    if(NOT ${name} IN_LIST __cmut_EP_build_module_done_list)

        # add to build_stack
        list(APPEND __cmut_EP_build_module_stack ${name})
        cmut_debug("__cmut_EP_build_module : build_module_stack ${__cmut_EP_build_module_stack}")

        if(CMUT_EP_${module})

            # load and add dependencies
            __cmut_EP_include_module_dependencies(${name})
            __cmut_EP_build_module_dependencies(${name})

            # add module
            cmut_info("add module \"${name}\"")
            add_subdirectory(${CMUT_MODULE_PREFIX}/${name})

            # mark as done
            list(APPEND __cmut_EP_build_module_done_list ${name})
            cmut_debug("__cmut_EP_build_module : build_module_done_list ${__cmut_EP_build_module_done_list}")
        else()
            cmut_info("__cmut_EP_build_module : module ${name} not added (disable).")
        endif()

        # remove from build_stack
        list(REMOVE_ITEM __cmut_EP_build_module_stack ${name})
        cmut_debug("__cmut_EP_build_module : build_module_stack ${__cmut_EP_build_module_stack}")
    endif()

    cmut_debug("__cmut_EP_build_module(${name}) done")

endmacro()


macro(__cmut_EP_build_module_dependencies name)
    cmut_EP_make_depends(${name})
    foreach(module ${CMUT_EP_${name}_DEPENDS})
        __cmut_EP_build_module(${module})
    endforeach()
endmacro()


function(cmut_EP_run)
    foreach(module ${__CMUT_EP_MODULE_TO_BUILD})
        __cmut_EP_build_module(${module})
    endforeach()
endfunction()




function(__cmut_EP__on_change_version_name variable access value current_list_file stack)

    if(${access} STREQUAL "MODIFIED_ACCESS")
    message(WARNING "variable = ${variable}")
    message(WARNING "access = ${access}")
    message(WARNING "value = ${value}")
    message(WARNING "current_list_file = ${current_list_file}")
    message(WARNING "stack = ${stack}")
        set(${variable}_save "toto" CACHE STRING "${name} version to build")
        __cmut_ep_version_to_name(${value} CMUT_EP_${name}_VERSION_NAME)
    endif()
endfunction()







macro(cmut_EP_add_variable_if_defined __list __variable)
    if(${__variable})
        list(APPEND ${__list} "-D${__variable}=${${__variable}}")
    endif()
endmacro()

function(cmut_EP_collect_cmake_variable resultVariable)

    set(__cmake_vars)

    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_C_COMPILER)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_CXX_COMPILER)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_TOOLCHAIN_FILE)

    cmut_EP_add_variable_if_defined(__cmake_vars BUILD_SHARED_LIBS)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_PREFIX)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_BUILD_TYPE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_PREFIX_PATH)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_VERBOSE_MAKEFILE)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_INSTALL_RPATH)

    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_ARCHITECTURES)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_DEPLOYMENT_TARGET)
    cmut_EP_add_variable_if_defined(__cmake_vars CMAKE_OSX_SYSROOT)

    set(${resultVariable} ${__cmake_vars} PARENT_SCOPE)

endfunction()



macro(cmut_EP_add_config_arg)
    if(NOT module)
        cmut_error("\"module\" variable not defined. Can't use cmut_EP_* macro.")
    endif()
    cmut_debug("cmut_EP_add_config_arg( ${ARGN} )")
    list(APPEND CMUT_EP_${module}_CONFIG_ARG "${ARGN}")
endmacro()

macro(cmut_EP_add_config_arg_if test true_arg false_arg)
    if(${test})
        cmut_EP_add_config_arg("${true_arg}")
    else()
        cmut_EP_add_config_arg("${false_arg}")
    endif()
endmacro()



macro(cmut_EP_autotools_adapt_cmake_var)
   cmut_EP_add_config_arg("--prefix=${CMAKE_INSTALL_PREFIX}")
   cmut_EP_add_config_arg_if(BUILD_SHARED_LIBS "--enable-shared;--disable-static" "--disable-shared;--enable-static")

   cmut_EP_add_config_arg_if(CMAKE_C_COMPILER "CC=${CMAKE_C_COMPILER}" "")
   cmut_EP_add_config_arg_if(CMAKE_CXX_COMPILER "CXX=${CMAKE_C_COMPILER}" "")


   if(CMAKE_CROSSCOMPILING)
       if(NOT CMAKE_CROSSCOMPILE_TRIPLET)
           cmut_fatal("cross compiling detected but \"CMAKE_CROSSCOMPILE_TRIPLET\" not defined. CMAKE_CROSSCOMPILE_TRIPLET is required to build autotools base project.")
           cmut_EP_add_config_arg("--host=${CMAKE_CROSSCOMPILE_TRIPLET}")
       endif()
   endif()
endmacro()




set(CMUT_EP_AUTOTOOLS_CONFIGURE_CMD configure)
macro(cmut_EP_autotools_config_build_install_command)
    set(CMUT_EP_${module}_CONFIGURE_CMD export PKG_CONFIG_PATH=${CMAKE_INSTALL_PREFIX}/lib/pkgconfig && ../${module}/${CMUT_EP_AUTOTOOLS_CONFIGURE_CMD} "${CMUT_EP_${module}_CONFIG_ARG}")
    set(CMUT_EP_${module}_BUILD_CMD     ${CMAKE_MAKE_PROGRAM} -j${CMUT_NUM_CORE_AVAILABLE})
    set(CMUT_EP_${module}_INSTALL_CMD   ${CMAKE_MAKE_PROGRAM} install)

endmacro()

macro(cmut_EP_assemble_config_build_install_command)

    __cmut_EP_test_variable(module)
    __cmut_EP_test_variable(CMUT_EP_${module}_CONFIGURE_CMD)
    __cmut_EP_test_variable(CMUT_EP_${module}_BUILD_CMD)
    __cmut_EP_test_variable(CMUT_EP_${module}_INSTALL_CMD)


    set(CMUT_EP_${module}_CONFIG_BUILD_INSTALL
        CONFIGURE_COMMAND
            ${CMUT_EP_${module}_CONFIGURE_CMD}
        BUILD_COMMAND
            ${CMUT_EP_${module}_BUILD_CMD}
        INSTALL_COMMAND
            ${CMUT_EP_${module}_INSTALL_CMD}
        )

endmacro()







function(cmut_EP_add_version name version)

    __cmut_EP_version_to_name(${version} version_name)

    set(CMUT_EP_${name}_${version_name}_DOWNLOAD_CMD "${ARGN}" PARENT_SCOPE)

endfunction()



function(__cmut_EP_test_variable var)

    if (NOT ${var})
        cmut_fatal("cmake variable \"${var}\" not defined. abort.")
    endif()
endfunction()


function(cmut_EP_assemble_download_command)

    __cmut_EP_test_variable(module)
    __cmut_EP_test_variable(CMUT_EP_${module}_VERSION_NAME)
    __cmut_EP_test_variable(CMUT_EP_${module}_${CMUT_EP_${module}_VERSION_NAME}_DOWNLOAD_CMD)


    set(CMUT_EP_${module}_DOWNLOAD_CMD
        ${CMUT_EP_${module}_${CMUT_EP_${module}_VERSION_NAME}_DOWNLOAD_CMD}
        PARENT_SCOPE)

endfunction()

function(cmut_EP_assemble_log_command)

    __cmut_EP_test_variable(module)

    set(
        CMUT_EP_${module}_LOG_CMD___disable
        LOG_DOWNLOAD 1
        LOG_UPDATE 1
        LOG_CONFIGURE 1
        LOG_BUILD 1
        LOG_TEST 1
        LOG_INSTALL 1
	PARENT_SCOPE
    )

endfunction()


endif(NOT DEFINED ${CMAKE_CURRENT_LIST_FILE}_include)
