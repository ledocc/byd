


include("${BYD_ROOT}/cmake/modules/byd__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_package_arg package step arg)
    byd__set_property(BYD__EP__${step}__${arg}__${package} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_arg package step arg result)
    byd__get_property(BYD__EP__${step}__${arg}__${package} __property_value)
    set(${result} "${__property_value}" PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_default_arg step arg)
    byd__set_property(BYD__EP__${step}__${arg} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_default_arg step arg result)
    byd__get_property(BYD__EP__${step}__${arg} __property_value)
    set(${result} "${__property_value}" PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_or_default_arg package step arg result)

    set(__property_value "")

    byd__EP__get_package_arg(${package} ${step} ${arg} __property_value)
    if(NOT __property_value)
        byd__EP__get_default_arg(${step} ${arg} __property_value)
    endif()

    set(${result} "${__property_value}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
