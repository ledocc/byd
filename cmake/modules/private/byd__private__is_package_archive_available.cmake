

function(byd__private__is_package_archive_available package result)

    byd__archive__find_package_archive_path(${package} archive_path)

    if (EXISTS ${archive_path})
        byd__func__return_value(1)
    else()
        byd__func__return_value(0)
    endif()

endfunction()
