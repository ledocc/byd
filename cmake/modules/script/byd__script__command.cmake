include("${BYD_ROOT}/cmake/modules/script/byd__script__function.cmake")
include("${BYD_ROOT}/cmake/modules/script/byd__script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__define_function__run_command_or_abort)

    byd__script__return_if_function_defined_else_define("run_command_or_abort")
    byd__script__write_function(
"
function(run_command_or_abort command)

    execute_process(\${command} RESULT_VARIABLE result)
    if(result)
        set(msg \"Command failed (\${result}):\\n\")
        foreach(arg IN LISTS \${command})
            set(msg \"\${msg} \'\${arg}\'\")
        endforeach()
        message(FATAL_ERROR \"\${msg}\")
    endif()
endfunction()
"
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__define_function__run_command)

    byd__script__return_if_function_defined_else_define("run_command")
    byd__script__write_function(
"
function(run_command command)

    execute_process(\${command} RESULT_VARIABLE result)
    if(result)
        set(msg \"Command failed (\${result}):\\n\")
        foreach(arg IN LISTS \${command})
            set(msg \"\${msg} \'\${arg}\'\")
        endforeach()
        message(WARNING \"\${msg}\")
    endif()
endfunction()
"
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__command)

	if( ARGV0 STREQUAL "COMMAND")
		set( command "${ARGN}" )
	else()
		set( command "COMMAND;${ARGN}")
	endif()
    byd__script__define_function__run_command_or_abort()
    byd__script__write("run_command_or_abort(\"${command}\")")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__try_command)

	if( ARGV0 STREQUAL "COMMAND")
		set( command "${ARGN}" )
	else()
		set( command "COMMAND;${ARGN}")
	endif()
    byd__script__define_function__run_command()
    byd__script__write("run_command(\"${command}\")")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
