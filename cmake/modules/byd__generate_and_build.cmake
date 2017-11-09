


include("${CMUT_ROOT}/utils/cmut__utils__directory.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__execute_process.cmake")

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

    set(cmake_arg_to_forward
        CMAKE_BUILD_TYPE
        CMAKE_TOOLCHAIN_FILE
        )

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
        LOG_FILE ${log_dir}/configure
        FATAL
        )

    cmut_info("[byd] : build step ... (this could take a while)")
    cmut__utils__execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j1
        WORKING_DIRECTORY "${build_dir}"
        LOG_FILE ${log_dir}/build
        FATAL
        )

    cmut_info("[byd] : dependencies configuration/build done.")

endfunction()
