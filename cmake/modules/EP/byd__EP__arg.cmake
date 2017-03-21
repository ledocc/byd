


include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_package_argument package step parameter)
    byd__func__set_property(BYD__EP__${step}__${parameter}__${package} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_argument package step parameter result)
    byd__func__get_property(BYD__EP__${step}__${parameter}__${package} argument)
    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_default_argument step parameter)
    byd__func__set_property(BYD__EP__${step}__${parameter} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_default_argument step parameter result)
    byd__func__get_property(BYD__EP__${step}__${parameter} argument)
    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_or_default_argument package step parameter result)

    byd__EP__get_package_argument(${package} ${step} ${parameter} argument)
    if(NOT argument)
        byd__EP__get_default_argument(${step} ${parameter} argument)
    endif()

    byd__func__return(argument)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
