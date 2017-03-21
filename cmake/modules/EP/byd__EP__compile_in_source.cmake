

include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")


function(byd__EP__compile_in_source package value)

    byd__EP__set_package_argument(${package} BUILD BUILD_IN_SOURCE 1)

endfunction()

function(byd__EP__get_compile_in_source package result)

    byd__EP__get_package_argument(${package} BUILD BUILD_IN_SOURCE build_in_source)
    if(NOT build_in_source)
        set(build_in_source 0)
    endif()
    byd__func__return(build_in_source)

endfunction()
