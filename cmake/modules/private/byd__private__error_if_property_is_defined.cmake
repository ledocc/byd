

include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${CMUT_ROOT}/cmut_message.cmake")

function(byd__private__error_if_property_is_defined property_name)

    byd__func__is_property(${property_name} result)

    if(result)
        cmut_fatal("property is already defined.")
    endif()

endfunction()
