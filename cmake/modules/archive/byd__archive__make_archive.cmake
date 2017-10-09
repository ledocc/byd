


# byd__archive__make_archive(NAME archive_name
#                            SOURCE file/dir1 [file/dir2 ...]
#                            [DESTINATION destination_dir])
#
# byd__archive__make_archive create an archive. Its name is defined by
# the NAME parameter, containing files/directories difined by the SOURCE parameter
# and placed in the directory defined by the DESTINATION parameter, or in current
# directory if not specified.


function(byd__archive__create_archive archive source)

    file(GLOB files_and_directories
        LIST_DIRECTORIES true
        RELATIVE ${source}
        ${source}/*
        )

    set(command ${CMAKE_COMMAND} -E tar Jcvf ${archive} ${files_and_directories})

    __byd__archive__execute_process(
        byd__archive__create_archive
        COMMAND ${command}
        WORKING_DIRECTORY ${source}
        )

endfunction()



function(byd__archive__extract_archive archive destination)

    set(mkdir_command ${CMAKE_COMMAND} -E make_directory "${destination}")
    set(extract_command ${CMAKE_COMMAND} -E tar Jxvf ${archive})

    cmut_debug("mkdir_command = ${mkdir_command}")

    execute_process(
        COMMAND ${mkdir_command}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output_var
        ERROR_VARIABLE error_var
        )
    if(NOT "${result}" STREQUAL "0")
        cmut_warn("execute_process failed.\ncommand \"${command}\" return ${result}.\noutput : ${output_var}\nerror  : ${error_var}")
    endif()

    execute_process(
        COMMAND ${extract_command}
        WORKING_DIRECTORY ${destination}
        RESULTS_VARIABLE results
        OUTPUT_VARIABLE output_var
        ERROR_VARIABLE error_var
        )

    foreach(result IN LISTS results)
        if(NOT "${result}" STREQUAL "0")
            cmut_warn("execute_process failed.\ncommand \"${command}\" return ${result}.\noutput : ${output_var}\nerror  : ${error_var}")
        endif()
    endforeach()

endfunction()


function(__byd__archive__execute_process function_name)

    execute_process(
        ${ARGN}
        RESULT_VARIABLE result_var
        OUTPUT_VARIABLE output_var
        ERROR_VARIABLE error_var
        )

    if(${result})
        cmut_warn("${function_name} failed.")
        cmut_warn("command \"${command}\" return ${result}.")
        cmut_warn(" output : ${output_var}")
        cmut_warn(" error  : ${error_var}")
    endif()


endfunction()
