include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/script/byd__script__function.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__begin script_name)

    byd__func__set_property(BYD__SCRIPT__CURRENT_SCRIPT_NAME "${script_name}")
    byd__func__set_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT "")
    byd__func__set_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT__FUNCTION "")

    byd__script__reset_function_defined()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__end)

    byd__func__get_property(BYD__SCRIPT__CURRENT_SCRIPT_NAME    script_name)
    byd__func__get_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT__FUNCTION script_content_function)
    byd__func__get_property(BYD__SCRIPT__CURRENT_SCRIPT_CONTENT script_content)

    file(WRITE "${script_name}" "${script_content_function}" "${script_content}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__write string)

    byd__func__concat_to_property(
        BYD__SCRIPT__CURRENT_SCRIPT_CONTENT
        "${string}\n"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__script__write_function string)

    byd__func__concat_to_property(
        BYD__SCRIPT__CURRENT_SCRIPT_CONTENT__FUNCTION
        "${string}\n"
        )
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
