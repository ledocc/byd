

include("${CMUT_ROOT}/utils/cmut__utils__execute_process.cmake")

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__archive__rsync__find_rsync)

    find_program(
        RSYNC_COMMAND
        NAMES rsync
        DOC "rsync tool used to upload/download package archives."
        )

    if(NOT RSYNC_COMMAND)
        cmut_fatal("[byd][archive] : rsync tool not found. Can't upload/download archives.")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__archive__rsync__prepare_rsync_command package archive_path result)

    if(NOT RSYNC_COMMAND)
        __byd__archive__rsync__find_rsync()
    endif()

    list(APPEND rsync_opts "-arv" )
    list(APPEND rsync_opts "--prune-empty-dirs")
    list(APPEND rsync_opts --include "${archive_path}")
    list(APPEND rsync_opts --include "*/")
    list(APPEND rsync_opts --exclude "*")

    byd__func__return(rsync_opts)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__rsync__upload_archive package)

    if (ARGC EQUAL 1)
        byd__archive__get_local_package_archive_path(${package} archive_path)
    else()
        set(archive_path "${ARGN}")
    endif()

    __byd__archive__rsync__prepare_rsync_command("${package}" "${archive_path}" rsync_opts)


    byd__archive__get_local_repository(local_repo)
    byd__archive__get_remote_repository(remote_repo)
    byd__archive__get_archive_root_dir(root_dir)

    list(APPEND rsync_opts "${root_dir}")
    list(APPEND rsync_opts "${remote_repo}")


    cmut_debug("[byd][archive][rsync] : cmut__utils__execute_process(")
    cmut_debug("[byd][archive][rsync] :     COMMAND ${RSYNC_COMMAND} ${rsync_opts}")
    cmut_debug("[byd][archive][rsync] :     WORKING_DIRECTORY ${local_repo}")
    cmut_debug("[byd][archive][rsync] :     FATAL )")


    cmut__utils__execute_process(
        COMMAND ${RSYNC_COMMAND} "${rsync_opts}"
        WORKING_DIRECTORY "${local_repo}"
        FATAL
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__rsync__download_archive package)

    byd__archive__get_local_package_archive_path(${package} archive_path)
    __byd__archive__rsync__prepare_rsync_command("${package}" "${archive_path}" rsync_opts)

    if(NOT RSYNC_COMMAND)
        cmut_warn("[byd][archive] : rsync tool not found. Can't upload/download archives.")
    endif()


    byd__archive__get_local_repository(local_repo)
    byd__archive__get_remote_repository(remote_repo)
    byd__archive__get_archive_root_dir(root_dir)

    list(APPEND rsync_opts "${remote_repo}/${root_dir}")
    list(APPEND rsync_opts "${local_repo}")


    cmut_debug("[byd][archive][rsync] : cmut__utils__execute_process(")
    cmut_debug("[byd][archive][rsync] :     COMMAND ${RSYNC_COMMAND} ${rsync_opts}")
    cmut_debug("[byd][archive][rsync] :     WORKING_DIRECTORY ${local_repo}")
    cmut_debug("[byd][archive][rsync] :     FATAL )")


    cmut__utils__mkdir(${local_repo})
    cmut__utils__execute_process(
        COMMAND ${RSYNC_COMMAND} "${rsync_opts}"
        WORKING_DIRECTORY "${local_repo}"
        )

endfunction()
