


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/upload_archive/enable.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__action__upload_archive package)

    byd__package__get_source_dir(${package} source_dir)
    byd__package__get_script_dir(${package} script_dir)

    byd__archive__get_local_repository(local_repo)
    byd__archive__get_remote_repository(remote_repo)


    byd__archive__get_local_package_archive_path(${package} archive_path)

    configure_file(
        "${BYD_ROOT}/cmake/modules/EP/step/upload_archive/upload_archive.cmake.in"
        "${script_dir}/upload_archive.cmake"
        @ONLY
        )


    byd__EP__set_package_argument(${package}
        UPLOAD_ARCHIVE COMMAND
        ${CMAKE_COMMAND} -P "${script_dir}/upload_archive.cmake"
        )

    byd__EP__set_package_argument(${package}
        UPLOAD_ARCHIVE WORKING_DIRECTORY
        "${source_dir}"
        )


    byd__EP__step__upload_archive__enable(${package})


endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
