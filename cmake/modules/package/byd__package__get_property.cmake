


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_prefix package result)

    byd__EP__get_package_arg(${package} GENERAL PREFIX prefix)

    if(NOT prefix)
        set(prefix "${package}-prefix")
    endif()

    if(NOT IS_ABSOLUTE prefix)
        set(prefix "${CMAKE_BINARY_DIR}/${prefix}")
    endif()

    set(${result} "${prefix}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_script_dir package result)

    byd__package__get_prefix(${package} prefix)

    set(${result} "${prefix}/src/${package}-script" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
