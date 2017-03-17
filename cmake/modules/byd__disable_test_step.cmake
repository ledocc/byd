


include("${BYD_ROOT}/cmake/modules/byd__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__disable_test_step value)

    byd__set_property(BYD__DISABLE_TEST_STEP ${value})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__is_disable_test_step result)

    byd__get_property(BYD__DISABLE_TEST_STEP value)
    if(NOT value)
        set(value 0)
    endif()

    set(${result} ${value} PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
