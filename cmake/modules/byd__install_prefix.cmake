

include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__set_install_prefix prefix)
    byd__func__set_property(BYD__INSTALL_PREFIX "${prefix}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_install_prefix result)
    byd__func__get_property(BYD__INSTALL_PREFIX prefix)
    byd__func__return(prefix)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
