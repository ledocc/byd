

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

function(__byd__archive__rsync__prepare_rsync_command result package)

    if(NOT RSYNC_COMMAND)
        __byd__archive__rsync__find_rsync()
    endif()

    cmut__utils__parse_arguments(
        __byd__archive__rsync__prepare_rsync_command
        ARG_
        ""
        "ARCHIVE_PATH;CMAKE_ARGS_PATH"
        ""
        ${ARGN}
        )



    list(APPEND rsync_opts "-arv" )
    list(APPEND rsync_opts "--prune-empty-dirs")
    if( "${ARG__ARCHIVE_PATH}" STREQUAL "" )
        cmut_fatal("[byd][archive][rsync] - Archive path not defined in prepare_rsync_command.")
    else()
        list(APPEND rsync_opts --include "${ARG__ARCHIVE_PATH}")
    endif()

    if( NOT "${ARG__CMAKE_ARGS_PATH}" STREQUAL "" )
        list(APPEND rsync_opts --include "${ARG__CMAKE_ARGS_PATH}")
    endif()

    if(CMAKE_HOST_WIN32)
        # we have to protect * on windows otherwise all archive are sync
        list(APPEND rsync_opts --include "\'*/\'")
        list(APPEND rsync_opts --exclude "\'*\'")
    else()
        list(APPEND rsync_opts --include "*/")
        list(APPEND rsync_opts --exclude "*")
    endif()

    byd__func__return(rsync_opts)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__archive__rsync__adapt_local_path_for_msys2_on_windows local_repo result)

    if(NOT CMAKE_HOST_WIN32)
        byd__func__return( local_repo )
        return()
    endif()

    string(REGEX REPLACE "^([a-zA-Z]):" "/\\1" msys2_local_repo "${local_repo}")
    byd__func__return(msys2_local_repo)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__rsync__upload_archive package)

    cmut__utils__parse_arguments(
        byd__archive__rsync__upload_archive
        ARG_
        ""
        "ARCHIVE_PATH;CMAKE_ARGS_PATH"
        ""
        ${ARGN}
        )


    __byd__archive__rsync__prepare_rsync_command(
        rsync_opts "${package}"
        ARCHIVE_PATH "${ARG__ARCHIVE_PATH}"
        CMAKE_ARGS_PATH "${ARG__CMAKE_ARGS_PATH}"
        )

    byd__archive__get_local_repository(local_repo)
    byd__archive__get_remote_repository(remote_repo)
    byd__archive__get_or_detect_system_id(system_id)

    list(APPEND rsync_opts "${system_id}")
    list(APPEND rsync_opts "${remote_repo}")


    cmut_debug("[byd][archive][rsync] : cmut__utils__execute_process(")
    cmut_debug("[byd][archive][rsync] :     COMMAND ${RSYNC_COMMAND} ${rsync_opts}")
    cmut_debug("[byd][archive][rsync] :     WORKING_DIRECTORY ${local_repo}")
    cmut_debug("[byd][archive][rsync] :     FATAL )")


    cmut__utils__execute_process(
        COMMAND "${RSYNC_COMMAND}" "${rsync_opts}"
        WORKING_DIRECTORY "${local_repo}"
        FATAL
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__rsync__download_archive package)

    byd__archive__get_package_archive_path(${package} archive_path)
    __byd__archive__rsync__prepare_rsync_command(
        rsync_opts "${package}"
        ARCHIVE_PATH "${archive_path}"
        )

    if(NOT RSYNC_COMMAND)
        cmut_warn("[byd][archive] : rsync tool not found. Can't upload/download archives.")
    endif()


    byd__archive__get_local_repository(local_repo)
    byd__archive__get_remote_repository(remote_repo)
    byd__archive__get_or_detect_system_id(system_id)

    list(APPEND rsync_opts "${remote_repo}/${system_id}")
    __byd__archive__rsync__adapt_local_path_for_msys2_on_windows("${local_repo}" adapted_local_repo)
    list(APPEND rsync_opts "${adapted_local_repo}")


    cmut_debug("[byd][archive][rsync] : cmut__utils__execute_process(")
    cmut_debug("[byd][archive][rsync] :     COMMAND ${RSYNC_COMMAND} ${rsync_opts}")
    cmut_debug("[byd][archive][rsync] :     WORKING_DIRECTORY ${local_repo}")
    cmut_debug("[byd][archive][rsync] :     FATAL )")


    cmut__utils__mkdir(${local_repo})
    cmut__utils__execute_process(
        COMMAND "${RSYNC_COMMAND}" "${rsync_opts}"
        WORKING_DIRECTORY "${local_repo}"
        FATAL
        )

endfunction()
