


include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__is_defined_component_argument package step parameter result)
    byd__package__split_package_component_name(${package} package_name component_name)

    byd__func__is_defined_property(BYD__EP__${step}__${parameter}__${package_name}__${component_name} is_defined)
    byd__func__return(is_defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_component_argument package step parameter result)
    byd__package__split_package_component_name(${package} package_name component_name)

    byd__func__get_property(BYD__EP__${step}__${parameter}__${package_name}__${component_name} argument)
    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_component_argument package step parameter)
    byd__package__split_package_component_name(${package} package_name component_name)

    byd__func__define_property(BYD__EP__${step}__${parameter}__${package_name}__${component_name})
    byd__func__set_property(BYD__EP__${step}__${parameter}__${package_name}__${component_name} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_property_name package result)
    byd__package__split_package_component_name(${package} package_name component_name)

    if("${component_name}" STREQUAL "")
        set(property_name BYD__EP__${step}__${parameter}__${package_name})
    else()
        set(property_name BYD__EP__${step}__${parameter}__${package_name}__${component_name})
    endif()

    byd__func__return(property_name)
endfunction()

function(byd__EP__is_defined_package_argument package step parameter result)
    byd__package__split_package_component_name(${package} package_name component_name)

    byd__func__is_defined_property(BYD__EP__${step}__${parameter}__${package_name} is_defined)
    byd__func__return(is_defined)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__set_package_argument package step parameter)
    byd__EP__get_package_property_name(${package} property_name)

    byd__func__define_property(${property_name})
    byd__func__set_property(${property_name} "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__get_package_argument package step parameter result)
    byd__package__split_package_component_name(${package} package_name component_name)

    byd__func__get_property(BYD__EP__${step}__${parameter}__${package_name} argument)

    byd__func__return(argument)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
