


include("${BYD_ROOT}/cmake/modules/option/private/get_default.cmake")
include("${BYD_ROOT}/cmake/modules/option/private/make_absolute_cmake_path.cmake")

include("${BYD_ROOT}/cmake/modules/byd__prefix.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__prefix)

    byd__option__private__get_default("BYD__OPTION__PREFIX" "${CMAKE_BINARY_DIR}" default_prefix)

    byd__option__private__make_absolute_cmake_path("${default_prefix}" default_prefix__absolute_cmake_path)


    set(BYD__OPTION__PREFIX
        "${default_prefix__absolute_cmake_path}"
        CACHE
        PATH
        "Specifies the ABSOLUTE path where packages are build. Usefull on Windows where path have limited length."
        FORCE
        )

    byd__set_prefix("${BYD__OPTION__PREFIX}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
