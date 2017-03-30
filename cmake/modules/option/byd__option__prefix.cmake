
include("${BYD_ROOT}/cmake/modules/private/byd__private__num_core_available.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__prefix)

    set(BYD__OPTION__PREFIX "" CACHE STRING "Specifies tge path where packages are build")
    byd__set_prefix(${BYD__OPTION__PREFIX})

    variable_watch(BYD__OPTION__PREFIX byd__private__update_option_prefix)

endfunction()


function(byd__private__update_option_prefix variable access value current_list_file stack)

    cmut__variable_watch__log_arguments("${variable}" "${access}" "${value}" "${current_list_file}" "${stack}")

    if(access STREQUAL "MODIFIED_ACCESS")
        byd__set_prefix("${value}")
    endif()

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
