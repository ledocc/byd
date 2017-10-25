
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_default_repository result)

    byd__func__return_value("$ENV{HOME}/.byd")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_repository result)

    set(byd_local_repo_env_var "BYD_LOCAL_REPO")

    set(repository "$ENV{${byd_local_repo_env_var}}")

    if("x${${byd_local_repo_env_var}}" STREQUAL "x")
        byd__archive__get_default_repository(repository)
    endif()

    cmut_debug("[byd][archive] : local repository used : ${repository}")

    byd__func__return(repository)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__archive__get_remote_repository_env_var result)
    byd__func__return_value("BYD_REMOTE_REPO")
endfunction()

function(byd__archive__get_remote_repository result)

    __byd__archive__get_remote_repository_env_var(byd_remote_repo_env_var)

    set(repository "$ENV{${byd_remote_repo_env_var}}")

    if("x${repository}" STREQUAL "x")
        cmut_warn("[byd][archive] : ${byd_remote_repo_env_var} environment variable not defined. Abort upload.")
    else()
        cmut_debug("[byd][archive] : remote repository used : ${repository}")
    endif()

    byd__func__return(repository)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__is_remote_repository_defined result)

    __byd__archive__get_remote_repository_env_var(byd_remote_repo_env_var)

    set(repository "$ENV{${byd_remote_repo_env_var}}")

    if("x${repository}" STREQUAL "x")
        byd__func__return_value(0)
    else()
        byd__func__return_value(1)
    endif()

endfunction()
