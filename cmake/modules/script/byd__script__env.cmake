include("${BYD_ROOT}/cmake/modules/func.cmake")

include("${BYD_ROOT}/cmake/modules/script/byd__script.cmake")
include("${BYD_ROOT}/cmake/modules/script/byd__script__function.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##



function(byd__script__env__get_separator result)

    if(UNIX)
        byd__func__return_value(":")
    else()
        byd__func__return_value(";")
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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__define_function__add_env)

    byd__script__return_if_function_defined_else_define("add_env")


    byd__script__env__get_separator(separator)
    byd__script__write_function(
"
cmake_policy(SET CMP0057 NEW)
function(add_env variable value)
    set(__new_value \"\${value}\")
    set(__tmp_value \$ENV{\${variable}})
    if(NOT \"x\${__tmp_value}\" STREQUAL \"x\")
        if(BEFORE IN_LIST ARGN)
            set(__new_value \"\${__new_value}${separator}\${__tmp_value}\")
        else()
            set(__new_value \"\${__tmp_value}${separator}\${__new_value}\")
        endif()
    endif()
    set(ENV{\${variable}} \"\${__new_value}\")
endfunction()
"
    )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__append variable value)

    byd__script__env__define_function__add_env()

    byd__script__env__handle_variable_type(${variable} ${value} variable value)
    byd__script__write("add_env(${variable} \"${value}\")")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__prepend variable value)
    byd__script__env__define_function__add_env()

    byd__script__env__handle_variable_type(${variable} ${value} variable value)
    byd__script__write("add_env(${variable} \"${value}\" BEFORE)")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__env__set variable value)

    byd__script__env__handle_variable_type("${variable}" "${value}" variable value)
    byd__script__write("set(ENV{${variable}} \"${value}\")")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
