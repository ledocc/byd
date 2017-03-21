

include(ExternalProject)


function(byd__EP__step__fixup_dylib package script_dir)

    configure_file(
        "${CMAKE_CURRENT_LIST_DIR}/fixup_dylib.cmake.in"
        "${script_dir}/fixup_dylib.cmake"
        @ONLY
    )

    ExternalProject_Add_Step(
        ${package}
        fixup_dylib
        COMMAND
            ${CMAKE_COMMAND} -P "${script_dir}/fixup_dylib.cmake"
        DEPENDEES install
        WORKING_DIRECTORY "${script}"
    )

endfunction()
