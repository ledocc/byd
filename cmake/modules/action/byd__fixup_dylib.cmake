


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__fixup_dylib package)

    if(NOT APPLE)
        cmut_fatal("[byd] - [${package}] : fixup_dylib is only available on APPLE plateform.")
    endif()

    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)


    if(NOT IS_ABSOLUTE ${CMAKE_INSTALL_PREFIX})
        cmut_warn("CMAKE_INSTALL_PREFIX not absolute path. fixup_dylib will fail. use cmut__config__resolve_install_prefix to convert.")
        cmut_warn("use cmut__config__resolve_install_prefix to convert CMAKE_INSTALL_PREFIX to absolute path.")
    endif()


    configure_file(
        "${BYD_ROOT}/cmake/modules/EP/step/fixup_dylib/fixup_dylib.cmake.in"
        "${script_dir}/fixup_dylib.cmake"
        @ONLY
    )

    byd__EP__set_package_argument(${package}
        FIXUP_DYLIB COMMAND
        "${CMAKE_COMMAND}" -P "${script_dir}/fixup_dylib.cmake"
        )

    byd__EP__set_package_argument(${package}
        FIXUP_DYLIB WORKING_DIRECTORY
        "${source_dir}"
        )

    byd__EP__step__fixup_dylib__enable(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
