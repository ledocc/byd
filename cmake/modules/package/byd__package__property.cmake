

include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")

include("${BYD_ROOT}/cmake/modules/private/byd__private__assert_not_empty.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__get_property_name param result)
    byd__private__assert_not_empty("${package}")
    byd__func__return_value(BYD__PACKAGE__${param}__${package})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__set_property param value)
    __byd__package__get_property_name(${param} property_name)
    byd__func__set_property(${property_name} "${value}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__add_to_property param value)
    __byd__package__get_property_name(${param} property_name)
    byd__func__add_to_property(${property_name} "${value}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__add_unique_to_property param value)
    __byd__package__get_property_name(${param} property_name)
    byd__func__add_unique_to_property(${property_name} "${value}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__get_property param result)
    __byd__package__get_property_name(${param} property_name)

    byd__func__get_property(${property_name} value)
    byd__func__return(value)
endfunction()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
