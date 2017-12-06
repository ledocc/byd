

function(byd__EP__debug message)

    if(NOT BYD__EP__DEBUG)
        return()
    endif()

    cmut_debug("[byd][EP] - ${message}")

endfunction()
