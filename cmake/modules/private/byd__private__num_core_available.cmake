


include("${CMUT_ROOT}/system/cmut__system__num_core_available.cmake")

include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__private__set_num_core_available num_core)

    byd__func__set_property(BYD__NUM_CORE_AVAILABLE ${num_core})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__private__get_num_core_available result)

    byd__func__get_property(BYD__NUM_CORE_AVAILABLE num_core)
    byd__func__return(num_core)

endfunction()

function(cmut__variable_watch__log_arguments variable access value current_list_file stack)

    cmut_debug("variable ${variable} accessed in ${access} mode in file \"${current_list_file}\", value = \"${value}\"." )

endfunction()

function(byd__private__update_option_jobs variable access value current_list_file stack)

    cmut__variable_watch__log_arguments("${variable}" "${access}" "${value}" "${current_list_file}" "${stack}")

    if(access STREQUAL "MODIFIED_ACCESS")
        byd__private__set_num_core_available("${value}")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
