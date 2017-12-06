


function(byd__func__set_default variable default_value)
    if((NOT DEFINED ${variable}) OR ("x${${variable}}" STREQUAL "x"))
        set(${variable} ${default_value} PARENT_SCOPE)
    endif()
endfunction()
