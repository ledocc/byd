


include("${BYD_ROOT}/cmake/modules/option/private/get_default.cmake")



function(byd__option__force_build)

    byd__option__private__get_default("BYD__OPTION__FORCE_BUILD" "OFF" default_force_build)

    set(BYD__OPTION__FORCE_BUILD
        "${default_force_build}"
        CACHE
        PATH
        "Enable to force build of package, even if archive is available."
        FORCE
        )


    byd__option__private__get_default("BYD__OPTION__FORCE_BUILD__PACKAGE_LIST" "" default_force_build_list)

    set(BYD__OPTION__FORCE_BUILD__PACKAGE_LIST
        "${default_force_build_list}"
        CACHE
        PATH
        "List of package forced to build, all if empty."
        FORCE
        )

endfunction()
