


include("${BYD_ROOT}/cmake/modules/func.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__set_package_added package)
    byd__func__set_property(BYD__ADDED__${package} 1)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__is_package_added package result)
    byd__func__get_property(BYD__ADDED__${package} added)
    byd__func__return(added)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
