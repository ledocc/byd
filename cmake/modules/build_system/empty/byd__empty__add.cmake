


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__empty__add package)

    byd__EP__set_package_argument(${package} CONFIGURE CONFIGURE_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no configure step")
    byd__EP__set_package_argument(${package} BUILD     BUILD_COMMAND     "${CMAKE_COMMAND}" "-E" "echo" "no build step")
    byd__EP__set_package_argument(${package} INSTALL   INSTALL_COMMAND   "${CMAKE_COMMAND}" "-E" "echo" "no install step")

    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
