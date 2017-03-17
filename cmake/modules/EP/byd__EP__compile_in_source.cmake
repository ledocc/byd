

include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")


function(byd__EP__compile_in_source package value)

    byd__EP__set_package_arg(${package} BUILD BUILD_IN_SOURCE 1)

endfunction()

function(byd__EP__get_compile_in_source package result)

    byd__EP__get_package_arg(${package} BUILD BUILD_IN_SOURCE build_in_source)
    if(NOT build_in_source)
        set(build_in_source 0)
    endif()
    set(${result} ${build_in_source} PARENT_SCOPE)

endfunction()
