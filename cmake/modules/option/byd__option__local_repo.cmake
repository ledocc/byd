


include("${BYD_ROOT}/cmake/modules/option/private/get_default.cmake")
include("${BYD_ROOT}/cmake/modules/option/private/make_absolute_cmake_path.cmake")



function(byd__option__local_repo)

    if(CMAKE_HOST_WIN32)
        set(local_repo "$ENV{USERPROFILE}/.byd")
    elseif(CMAKE_HOST_UNIX)
        set(local_repo "$ENV{HOME}/.local/share/byd")
    else()
        set(local_repo "$ENV{HOME}/.byd")
    endif()


    byd__option__private__get_default("BYD__OPTION__LOCAL_REPO" "${local_repo}" default_local_repo)

    byd__option__private__make_absolute_cmake_path("${default_local_repo}" default_local_repo__absolute_cmake_path)
    set(BYD__OPTION__LOCAL_REPO
        "${default_local_repo__absolute_cmake_path}"
        CACHE
        PATH
        "Specifies the ABSOLUTE path where built packages archive are stored."
        FORCE
        )

    byd__archive__set_local_repository("${BYD__OPTION__LOCAL_REPO}")

endfunction()
