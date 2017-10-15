include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__define_property name)
    define_property(GLOBAL PROPERTY ${name} BRIEF_DOCS "internal byd property" FULL_DOCS "internal byd property")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__set_property name)
    set_property(GLOBAL PROPERTY ${name} ${ARGN})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__add_to_property name)

    byd__func__get_property(${name} __property_value)
    list(APPEND __property_value ${ARGN})

    set_property(GLOBAL PROPERTY ${name} "${__property_value}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__accum_to_property name)

    byd__func__get_property(${name} __property_value)
    set(__property_value "${__property_value} ${ARGN}")

    set_property(GLOBAL PROPERTY ${name} "${__property_value}")

endfunction()
##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__concat_to_property name)

    byd__func__get_property(${name} __property_value)
    set(__property_value "${__property_value}${ARGN}")

    set_property(GLOBAL PROPERTY ${name} "${__property_value}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__remove_from_property name)

    byd__func__get_property(${name} __property_value)
    list(REMOVE_ITEM __property_value ${ARGN})

    set_property(GLOBAL PROPERTY ${name} "${__property_value}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__get_property name result)
    get_property(__result GLOBAL PROPERTY ${name})
    byd__func__return(__result)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__is_set_property name result)
    get_property(__result GLOBAL PROPERTY ${name} SET)
    byd__func__return(__result)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__func__is_defined_property name result)
    get_property(__result GLOBAL PROPERTY ${name} DEFINED)
    byd__func__return(__result)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
