


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/extract_archive/enable.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__action__extract_archive package)

    byd__package__get_source_dir(${package} source_dir)
    byd__package__get_script_dir(${package} script_dir)



    set(package_install_dir "${CMAKE_INSTALL_PREFIX}")
    byd__archive__get_package_archive_path(${package} archive_path)
    byd__archive__get_local_repository(repository)
    set(archive_path "${repository}/${archive_path}")

    configure_file(
        "${BYD_ROOT}/cmake/modules/EP/step/extract_archive/extract_archive.cmake.in"
        "${script_dir}/extract_archive.cmake"
        @ONLY
        )


    byd__EP__set_package_argument(${package}
        EXTRACT_ARCHIVE COMMAND
        ${CMAKE_COMMAND} -P "${script_dir}/extract_archive.cmake"
        )

    byd__EP__set_package_argument(${package}
        EXTRACT_ARCHIVE WORKING_DIRECTORY
        "${source_dir}"
        )


    byd__EP__step__extract_archive__enable(${package})


endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__action__extract_archive__reset package)

    byd__package__get_stamp_dir(${package} stamp_dir)
    set(extract_archive-stamp-file "${stamp_dir}/${package}-extract_archive")

    if(NOT EXISTS "${extract_archive-stamp-file}")
        return()
    endif()

    cmut_info("[byd][action][extract_archive] - [${package}] : force reset of this step")
    cmut_debug("[byd][action][extract_archive] - [${package}] : remove \"${extract_archive-stamp-file}\"")

    file(REMOVE "${extract_archive-stamp-file}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
