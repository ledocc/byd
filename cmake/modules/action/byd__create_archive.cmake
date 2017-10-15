


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/create_archive/enable.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__action__create_archive package)

    byd__package__get_source_dir(${package} source_dir)
    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_install_dir(${package} install_dir)



    set(package_install_dir "${install_dir}")
    byd__archive__get_local_package_archive_path(${package} archive_path)
    byd__archive__get_default_repository(repository)
    set(archive_path "${repository}/${archive_path}")

    configure_file(
        "${BYD_ROOT}/cmake/modules/EP/step/create_archive/create_archive.cmake.in"
        "${script_dir}/create_archive.cmake"
        @ONLY
        )


    byd__EP__set_package_argument(${package}
        CREATE_ARCHIVE COMMAND
        ${CMAKE_COMMAND} -P "${script_dir}/create_archive.cmake"
        )

    byd__EP__set_package_argument(${package}
        CREATE_ARCHIVE WORKING_DIRECTORY
        "${source_dir}"
        )


    byd__EP__step__create_archive__enable(${package})


endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
