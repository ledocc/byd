


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__configure__add_arg package variable value)

    byd__func__add_to_property(BYD__EP__CONFIGURE__CMAKE_ARGS__${package} "-D${variable}=${value}")

endfunction()

function(byd__cmake__configure__get_arg package result)

    byd__func__get_property(BYD__EP__CONFIGURE__CMAKE_ARGS__${package} value)
    byd__func__return(value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
