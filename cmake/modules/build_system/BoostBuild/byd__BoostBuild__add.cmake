


include("${BYD_ROOT}/cmake/modules/build_system/BoostBuild/byd__BoostBuild__generate.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__add package)

    byd__BoostBuild__generate_configure_command(${package})
    byd__BoostBuild__generate_build_command(${package})
    byd__BoostBuild__generate_install_command(${package})

    if(BUILD_TESTING)
        byd__BoostBuild__generate_test_command(${package})
    endif()

    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
