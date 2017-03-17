

include("${BYD_ROOT}/cmake/modules/byd__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__set_prefix prefix)
    byd__set_property(BYD__PREFIX "${prefix}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_prefix result)
    byd__get_property(BYD__PREFIX prefix)
    set(${result} ${prefix} PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
