



function(byd__archive__get_package_path package result)

    byd__archive__find_package_archive_path(${package} archive_path)

    byd__func__return(archive_path)

endfunction()



function(byd__archive__install_archive package)

    byd__archive__get_package_path(${package} package_path)

    byd__archive__extract_archive("${package_path}" "${CMAKE_INSTALL_PREFIX}")

endfunction()
