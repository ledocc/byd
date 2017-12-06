


include("${CMUT_ROOT}/cmut_message.cmake")



function(byd__private__assert_not_empty value)

    if("${value}" STREQUAL "")
        cmut_fatal("value is empty.")
    endif()

endfunction()

function(byd__private__is_empty value result)

    if("${value}" STREQUAL "")
        set(is_empty 1)
    else()
        set(is_empty 0)
    endif()

    byd__func__return(is_empty)

endfunction()

function(byd__private__assert_empty value message)

    if(NOT "${value}" STREQUAL "")
        cmut_fatal("${message}")
    endif()

endfunction()
