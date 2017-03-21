


include("${BYD_ROOT}/cmake/modules/func.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__set_parameter_source step parameter source)
    byd__func__add_to_property(BYD__EP__STEP_INFO__PARAMETERS__${step} ${parameter})
    byd__func__set_property(BYD__EP__STEP_INFO__SOURCE__${step}__${parameter} ${source})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__get_parameter_source step parameter result)
    byd__func__get_property(BYD__EP__STEP_INFO__SOURCE__${step}__${parameter} source)
    byd__func__return(source)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__get_parameters step result)
    byd__func__get_property(BYD__EP__STEP_INFO__PARAMETERS__${step} parameters)

    byd__func__return(parameters)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__set_step_info_defined provider)
    byd__func__set_property(BYD__EP__STEP__${provider}__DEFINED 1)
    if(defined)
        return()
    endif()
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__is_step_info_defined provider result)
    byd__func__get_property(BYD__EP__STEP__${provider}__DEFINED defined)
    byd__func__return(defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

macro(byd__EP__step__return_if_defined_or_define property)

    byd__func__get_property(${property} defined)
    if(defined)
        return()
    endif()

    byd__func__set_property(${property} 1)

endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
