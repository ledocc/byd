

include("${CMUT_ROOT}/utils/cmut__utils__directory.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__execute_process.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/byd__get_cmake_args_in_build_id.cmake")

##--------------------------------------------------------------------------------------------------------------------##

function(byd__generate_and_build source_dir)

    cmut__utils__parse_arguments(
        byd__generate_and_build
        GEN_AND_BUILD_
        ""
        ""
        "CMAKE_ARGS"
        ${ARGN}
        )



    set(build_dir   "${PROJECT_BINARY_DIR}/byd/_build")
    set(install_dir "${PROJECT_BINARY_DIR}/byd/_install")
    set(log_dir     "${PROJECT_BINARY_DIR}/byd/_log")

    cmut_info("[byd] : source dir  = ${source_dir}")
    cmut_info("[byd] : build dir   = ${build_dir}")
    cmut_info("[byd] : install dir = ${install_dir}")
    cmut_info("[byd] : log dir     = ${log_dir}")


    cmut__utils__mkdir("${build_dir}")
    cmut__utils__mkdir("${log_dir}")



    list(APPEND cmake_args "-DCMAKE_INSTALL_PREFIX=${install_dir}")
    list(APPEND cmake_args "-G${CMAKE_GENERATOR}")


    # adjust CMAKE_BUILD_TYPE
    set(build_type_to_forward "Debug" "RelWithDebInfo")
    if(NOT "${CMAKE_BUILD_TYPE}" IN_LIST build_type_to_forward)
        set(CMAKE_BUILD_TYPE "Release")
    endif()


    byd__get_cmake_args_in_build_id(cmake_arg_to_forward)
    list(APPEND cmake_arg_to_forward CMAKE_VERBOSE_MAKEFILE)
    if(CMAKE_TOOLCHAIN_FILE)
        file(TO_CMAKE_PATH "${CMAKE_TOOLCHAIN_FILE}" CMAKE_TOOLCHAIN_FILE)
    endif()
    list(APPEND cmake_arg_to_forward CMAKE_TOOLCHAIN_FILE)
    list(APPEND cmake_arg_to_forward CMAKE_MODULE_PATH)

    foreach(cmake_arg IN LISTS cmake_arg_to_forward)
        if(NOT "${${cmake_arg}}" STREQUAL "")
            list(APPEND cmake_args "-D${cmake_arg}=${${cmake_arg}}")
        endif()
    endforeach()

    list(APPEND cmake_args "${GEN_AND_BUILD__CMAKE_ARGS}")

    list(APPEND cmake_args "${source_dir}")


    cmut_info("[byd] : configure step ...")
    cmut_info("[byd] : configure command ...")

    cmut__utils__execute_process(
        COMMAND ${CMAKE_COMMAND} "${cmake_args}"
        WORKING_DIRECTORY "${build_dir}"
        LOG_FILE "${log_dir}/configure"
        PRINT_LOG_ON_ERROR
        FATAL
        )


    if (NOT EXISTS "${build_dir}/target.list")

        cmut_info("[byd] : build step ... (this could take a while)")
        __byd__build("all")

    else()

        file(READ "${build_dir}/target.list" targets)

        foreach(target IN LISTS targets)
            cmut_info("[byd] : build \"${target}\"  ... (this could take a while)")
            __byd__build( ${target} )
        endforeach()

    endif()

    cmut_info("[byd] : dependencies configuration/build done.")

endfunction()


function(__byd__build target)

    cmut__utils__execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- ${target} -j1
        WORKING_DIRECTORY "${build_dir}"
        LOG_FILE "${log_dir}/build"
        PRINT_LOG_ON_ERROR
        )

endfunction()
