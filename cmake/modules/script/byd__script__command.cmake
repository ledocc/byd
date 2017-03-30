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
    execute_process(COMMAND \${command} RESULT_VARIABLE result)
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

function(byd__script__command)

    byd__script__define_function__run_command_or_abort()
    byd__script__write("run_command_or_abort(\"${ARGN}\")")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
