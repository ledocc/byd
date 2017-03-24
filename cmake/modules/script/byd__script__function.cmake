include("${BYD_ROOT}/cmake/modules/func.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__set_function_defined function_name)
    byd__func__add_to_property(BYD__SCRIPT__CURRENT_SCRIPT__DEFINED_FUNCTIONS "${function_name}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__reset_function_defined)
    byd__func__set_property(BYD__SCRIPT__CURRENT_SCRIPT__DEFINED_FUNCTIONS "")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__is_function_defined function_name result)
    byd__func__get_property(BYD__SCRIPT__CURRENT_SCRIPT__DEFINED_FUNCTIONS functions)
    if("${function_name}" IN_LIST functions)
        set(is_defined TRUE)
    else()
        set(is_defined FALSE)
    endif()
    byd__func__return(is_defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

macro(byd__script__return_if_function_defined_else_define function_name)
        byd__script__is_function_defined(${function_name} is_defined)
    if(is_defined)
        return()
    else()
        byd__script__set_function_defined(${function_name})
    endif()

endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
