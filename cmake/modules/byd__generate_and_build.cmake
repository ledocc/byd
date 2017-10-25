


include("${CMUT_ROOT}/utils/cmut__utils__directory.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__execute_process.cmake")

##--------------------------------------------------------------------------------------------------------------------##

function(byd__generate_and_build source_dir)

    set(build_dir   "${PROJECT_BINARY_DIR}/byd/_build")
    set(install_dir "${PROJECT_BINARY_DIR}/byd/_install")
    set(log_dir     "${PROJECT_BINARY_DIR}/byd/_log")

    cmut_info("[byd] : source dir  = ${source_dir}")
    cmut_info("[byd] : build dir   = ${build_dir}")
    cmut_info("[byd] : install dir = ${install_dir}")
    cmut_info("[byd] : log dir     = ${log_dir}")


    cmut__utils__mkdir("${build_dir}")
    cmut__utils__mkdir("${log_dir}")

    cmut__utils__execute_process(
        COMMAND ${CMAKE_COMMAND} "-DCMAKE_INSTALL_PREFIX=${install_dir}" "${source_dir}"
        WORKING_DIRECTORY "${build_dir}"
        LOG_FILE ${log_dir}/generate
        FATAL
        )

    cmut__utils__execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j1
        WORKING_DIRECTORY "${build_dir}"
        LOG_FILE ${log_dir}/build
        FATAL
        )

endfunction()
