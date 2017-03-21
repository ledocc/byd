


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")



function(byd__EP__set_default_log value)

    set(step_name LOG)

    set(args
        LOG_DOWNLOAD
        LOG_UPDATE
        LOG_CONFIGURE
        LOG_BUILD
        LOG_TEST
        LOG_INSTALL
        )

    foreach(arg IN LISTS args)
        byd__EP__set_default_argument(${step_name} ${arg} ${value})
    endforeach()

endfunction()

function(byd__EP__set_empty_command package)

    byd__EP__set_package_argument(${package} CONFIGURE CONFIGURE_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no configure step")
    byd__EP__set_package_argument(${package} BUILD     BUILD_COMMAND     "${CMAKE_COMMAND}" "-E" "echo" "no build step")
    byd__EP__set_package_argument(${package} INSTALL   INSTALL_COMMAND   "${CMAKE_COMMAND}" "-E" "echo" "no install step")
    byd__EP__set_package_argument(${package} TEST      TEST_COMMAND      "${CMAKE_COMMAND}" "-E" "echo" "no test step")

endfunction()
