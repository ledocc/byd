


include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__is_defined_package_argument package step parameter result)
    byd__func__is_defined_property(BYD__EP__${step}__${parameter}__${package} is_defined)
    byd__func__return(is_defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_package_argument package step parameter)
    byd__func__define_property(BYD__EP__${step}__${parameter}__${package})
    byd__func__set_property(BYD__EP__${step}__${parameter}__${package} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_argument package step parameter result)
    byd__func__get_property(BYD__EP__${step}__${parameter}__${package} argument)
    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__is_defined_default_argument step parameter result)
    byd__func__is_defined_property(BYD__EP__${step}__${parameter} is_defined)
    byd__func__return(is_defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_default_argument step parameter)
    byd__func__define_property(BYD__EP__${step}__${parameter})
    byd__func__set_property(BYD__EP__${step}__${parameter} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_default_argument step parameter result)
    byd__func__get_property(BYD__EP__${step}__${parameter} argument)
    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__is_defined_package_or_default_argument package step parameter result)

    byd__EP__is_defined_package_argument(${package} ${step} ${parameter} is_defined)
    if(NOT is_defined)
        byd__EP__get_default_argument(${step} ${parameter} is_defined)
    endif()

    byd__func__return(is_defined)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_or_default_argument package step parameter result)

    set(argument)

    byd__EP__is_defined_package_argument(${package} ${step} ${parameter} is_defined)
    if(is_defined)
        byd__EP__get_package_argument(${package} ${step} ${parameter} argument)
    else()
        byd__EP__is_defined_default_argument(${step} ${parameter} is_defined)
        if(is_defined)
            byd__EP__get_default_argument(${step} ${parameter} argument)
        endif()
    endif()

    byd__func__return(argument)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
