


include("${CMUT_ROOT}/cmut_message.cmake")



function(byd__private__assert_not_empty value)

    if("${value}" STREQUAL "")
        cmut_fatal("value is empty.")
    endif()

endfunction()
