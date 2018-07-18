


function(byd__hashtag__compute_hashtag str result)

    string(LENGTH "${str}" str_length)
    if(str_length EQUAL 0)
        byd__func__return_value("0")
        return()
    endif()

    string(SHA1 hash "${str}")
    byd__func__return(hash)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
