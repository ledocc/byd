
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__set_local_repository local_repo)

    byd__func__set_property(BYD__ARCHIVE__LOCAL_REPOSITORY "${local_repo}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_repository result)

    byd__func__get_property(BYD__ARCHIVE__LOCAL_REPOSITORY local_repo)

    cmut_debug("[byd][archive] : local repository used : ${local_repo}")

    byd__func__return(local_repo)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__set_system_id system_id)

    byd__func__set_property(BYD__ARCHIVE__SYSTEM_ID "${system_id}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_system_id result)

    byd__func__get_property(BYD__ARCHIVE__SYSTEM_ID system_id)

    cmut_debug("[byd][archive] : system id used : ${system_id}")

    byd__func__return(system_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_or_detect_system_id result)

    byd__archive__get_system_id( system_id )

    if("${system_id}" STREQUAL "")
        byd__archive__detect_system_id()
        byd__archive__get_system_id( system_id )
    endif()

    byd__func__return(system_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__detect_system_id)

    cmut__system__get_distribution_name(distribution_name)
    set(system_id "${distribution_name}")

    if (UNIX AND (NOT APPLE))
        cmut__system__get_distribution_version(distribution_version)
        set(system_id "${system_id}-${distribution_version}")
    endif()

    byd__archive__set_system_id( ${system_id} )

endfunction()
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__set_remote_repository remote_repo)

    byd__func__set_property(BYD__ARCHIVE__REMOTE_REPOSITORY "${remote_repo}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_remote_repository result)

    byd__func__get_property(BYD__ARCHIVE__REMOTE_REPOSITORY remote_repo)

    byd__func__return(remote_repo)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__is_remote_repository_defined result)

    byd__archive__get_remote_repository(remote_repo)

    if("${remote_repo}" STREQUAL "")
        byd__func__return_value(0)
    else()
        byd__func__return_value(1)
    endif()
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
