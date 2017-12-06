


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__archive__add package)

    byd__EP__set_package_argument(${package} DOWNLOAD DOWNLOAD_NO_EXTRACT 1)

    byd__EP__set_package_argument(${package} DOWNLOAD  DOWNLOAD_COMMAND  "${CMAKE_COMMAND}" "-E" "echo" "no configure step")
    byd__EP__set_package_argument(${package} CONFIGURE CONFIGURE_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no configure step")
    byd__EP__set_package_argument(${package} BUILD     BUILD_COMMAND     "${CMAKE_COMMAND}" "-E" "echo" "no build step")
    byd__EP__set_package_argument(${package} INSTALL   INSTALL_COMMAND   "${CMAKE_COMMAND}" "-E" "echo" "no install step")

    byd__action__extract_archive(${package})

    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
