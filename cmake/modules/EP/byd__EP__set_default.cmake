


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

    foreach(arg ${args})
        byd__EP__set_default_arg(${step_name} ${arg} ${value})
    endforeach()

endfunction()
