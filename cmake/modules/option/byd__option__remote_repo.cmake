


include("${BYD_ROOT}/cmake/modules/option/private/get_default.cmake")



function(byd__option__remote_repo)

    byd__option__private__get_default("BYD__OPTION__REMOTE_REPO" "" default_remote_repo)

    set(BYD__OPTION__REMOTE_REPO
        "${default_remote_repo}"
        CACHE
        PATH
        "Specifies the rsync remote path where built packages archive are uploaded/downloaded."
        FORCE
        )

    byd__archive__set_remote_repository("${BYD__OPTION__REMOTE_REPO}")

endfunction()
