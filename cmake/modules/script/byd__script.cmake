include("${CMUT_ROOT}/cmut_message.cmake")
include("${BYD_ROOT}/cmake/modules/byd__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##



function(byd__script__env__get_separator separator)

    if(UNIX)
        set(${separator} ":" PARENT_SCOPE)
    else()
        set(${separator} ";" PARENT_SCOPE)
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__get_variable_type variable variable_name variable_type)

    string(REPLACE ":" ";" variable ${variable})
    list(LENGTH variable length)

    if(length EQUAL 1)
        set(${variable_name} ${variable} PARENT_SCOPE)
        set(${variable_type} "UNDEFINED" PARENT_SCOPE)
    elseif(length EQUAL 2)
        list(GET variable 0 name)
        set(${variable_name} ${name} PARENT_SCOPE)
        list(GET variable 1 type)
        set(${variable_type} ${type} PARENT_SCOPE)
    else()
        cmut__fatal("byd__script__env__get_variable_type : invalid variable name : ${variable}")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__handle_variable_type variable_in value_in variable_out value_out)

    byd__script__env__get_variable_type(${variable_in} variable_name variable_type)

    if("${variable_type}" STREQUAL "PATH")
        file(TO_NATIVE_PATH "${value_in}" value)
        set(${value_out} "${value}" PARENT_SCOPE)
        set(${variable_out} "${variable_name}" PARENT_SCOPE)
    else()
        set(${value_out} "${value_in}" PARENT_SCOPE)
        set(${variable_out} "${variable_in}" PARENT_SCOPE)
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__begin script_name)

    byd__set_property(BYD__SCRIPT__CURRENT_SCRIPT_NAME "${script_name}")
    byd__set_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT "")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__end)

    byd__get_property(BYD__SCRIPT__CURRENT_SCRIPT_NAME    script_name)
    byd__get_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT script_content)

    file(WRITE "${script_name}" "${script_content}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__write string)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
"${string}
"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__append variable value)

    byd__script__env__get_separator(separator)
    byd__script__env__handle_variable_type(${variable} ${value} variable value)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
"
set(__new_value \"${value}\")
set(__tmp_value \$ENV{${variable}})
if(__tmp_value)
    set(__new_value \"\${__tmp_value}${separator}\${_new_value}\")
endif()
set(\$ENV{${variable}} \"\${__new_value}\")
"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__prepend variable value)

    byd__script__env__get_separator(separator)
    byd__script__env__handle_variable_type("${variable}" "${value}" variable value)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
"
set(__new_value \"${value}\")
set(__tmp_value \$ENV{${variable}})
if(__tmp_value)
    set(__new_value \"\${__tmp_value}${separator}\${_new_value}\")
endif()
set(\$ENV{${variable}} \"\${__new_value}\")
"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__set variable value)
    byd__script__env__handle_variable_type("${variable}" "${value}" variable value)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
        "set(\$ENV{${variable}} \"${value}\")\n"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__command)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
        "run_command_or_abort(\"${ARGN}\")\n"
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__add_run_command_or_abort_function)

    byd__concat_to_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
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
