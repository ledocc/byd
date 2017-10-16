


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/build_system/autotool/byd__autotool__generate.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__add.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__add package)

    cmut__utils__parse_arguments(
       byd__autotool__add
        PARAM
        ""
        "TEST_TARGET"
        "SKIP"
        "${ARGN}"
        )


    byd__autotool__generate_update_command(${package})
    byd__autotool__generate_configure_command(${package})
    byd__autotool__generate_build_command(${package})
    byd__autotool__generate_install_command(${package})

    if((NOT "test" IN_LIST PARAM_SKIP) AND BUILD_TESTING)
        if(PARAM_TEST_TARGET)
            set(TARGET_ARG TARGET ${PARAM_TEST_TARGET})
        endif()
        byd__autotool__generate_test_command(${package} ${TARGET_ARG})
    endif()
    byd__EP__add(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
