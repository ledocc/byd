


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/create_archive/enable.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    byd__EP__step__create_archive__is_enable(${package} is_enable)
    if(NOT is_enable)
        return()
    endif()

    byd__EP__set_package_argument(${package} CREATE_ARCHIVE COMMENT "Create reusable archive for \'${package}\'")

    byd__EP__step__collect_steps_arguments(${package} CREATE_ARCHIVE arguments)
    byd__EP__step__log_EP_Add_Step_command(${package} create_archive "${arguments}")

    ExternalProject_Add_Step(
        ${package}
        create_archive
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
