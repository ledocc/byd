

function(byd__variable__osx_sdk__define)

    if(APPLE)
        cmut__system__get_osx_sdk_short_name(osx_sdk)
    else()
        set(osx_sdk)
    endif()

    set(BYD__OSX_SDK ${osx_sdk} CACHE STRING "osx SDK used.")

endfunction()
