


include("${BYD_ROOT}/cmake/modules/build_system/BoostBuild/byd__BoostBuild__generate.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__add package)

    cmut__utils__parse_arguments(
       byd__BoostBuild__add
        PARAM
        ""
        ""
        "SKIP"
        "${ARGN}"
        )


    byd__BoostBuild__generate_configure_command(${package})
    byd__BoostBuild__generate_build_command(${package})
    byd__BoostBuild__generate_install_command(${package})

    if((BUILD_TESTING) AND (NOT "test" IN_LIST PARAM_SKIP))
        byd__BoostBuild__generate_test_command(${package})
    endif()

    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
