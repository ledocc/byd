

include("${BYD_ROOT}/cmake/modules/func.cmake")


function(byd__EP__step__custom_patch__enable package)
    byd__func__set_property(BYD__EP__STEP__CUSTOM_PATCH__ENABLE__${package} 1)
endfunction()

function(byd__EP__step__custom_patch__is_enable package result)
    byd__func__get_property(BYD__EP__STEP__CUSTOM_PATCH__ENABLE__${package} is_enable)
    byd__func__return(is_enable)
endfunction()
