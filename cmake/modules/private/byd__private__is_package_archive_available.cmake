

function(byd__private__is_package_archive_available package result)

    byd__archive__find_package_archive_path(${package} archive_path)

    if (EXISTS ${archive_path})
        byd__func__return_value(1)
        return()
    endif()

    byd__archive__is_remote_repository_defined(remote_repository_defined)
    if(NOT remote_repository_defined)
        byd__func__return_value(0)
        return()
    endif()

    byd__archive__rsync__download_archive(${package})
    byd__archive__find_package_archive_path(${package} archive_path)

    if (EXISTS ${archive_path})
        byd__func__return_value(1)
    else()
        byd__func__return_value(0)
    endif()


endfunction()
