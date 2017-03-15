
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__set_property name)
    set_property(GLOBAL PROPERTY ${name} ${ARGN})
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__add_to_property name)

    byd__get_property(${name} __property_value)
    list(APPEND __property_value ${ARGN})

    set_property(GLOBAL PROPERTY ${name} ${__property_value})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__accum_to_property name)

    byd__get_property(${name} __property_value)
    set(__property_value "${__property_value} ${ARGN}")

    set_property(GLOBAL PROPERTY ${name} ${__property_value})

endfunction()
##--------------------------------------------------------------------------------------------------------------------##

function(byd__concat_to_property name)

    byd__get_property(${name} __property_value)
    set(__property_value "${__property_value}${ARGN}")

    set_property(GLOBAL PROPERTY ${name} ${__property_value})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__remove_from_property name)

    byd__get_property(${name} __property_value)
    list(REMOVE_ITEM __property_value ${ARGN})

    set_property(GLOBAL PROPERTY ${name} ${__property_value})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_property name result)
    get_property(__result GLOBAL PROPERTY ${name})
    set(${result} ${__result} PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__is_property name result)
    get_property(__result GLOBAL PROPERTY ${name} SET)
    set(${result} ${__result} PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
