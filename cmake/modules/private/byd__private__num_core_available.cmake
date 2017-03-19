


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
    if(NOT num_core)
        cmut__system__get_num_core_available(num_core)
        byd__private__set_num_core_available(${num_core})
    endif()

    byd__func__return(num_core)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
