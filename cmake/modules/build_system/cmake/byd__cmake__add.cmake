


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/build_system/cmake/byd__cmake__generate.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__add package)

    cmut__utils__parse_arguments(
       byd__cmake__add
        PARAM
        ""
        ""
        "SKIP"
        "${ARGN}"
        )

    byd__cmake__generate_configure_cmake_args(${package})
    byd__cmake__generate_build_command(${package})
    byd__cmake__generate_install_command(${package})

    if((NOT ANDROID) AND (NOT "test" IN_LIST PARAM_SKIP) AND (BUILD_TESTING))
        byd__cmake__generate_test_command(${package})
    endif()

    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
