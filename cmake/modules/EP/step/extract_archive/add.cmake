


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/extract_archive/enable.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    byd__EP__step__extract_archive__is_enable(${package} is_enable)
    if(NOT is_enable)
        return()
    endif()

    byd__EP__set_package_argument(${package} EXTRACT_ARCHIVE COMMENT "Extract reusable archive for \'${package}\'")


    byd__EP__step__collect_steps_arguments(${package} EXTRACT_ARCHIVE arguments)
    byd__EP__step__log_EP_Add_Step_command(${package} extract_archive "${arguments}")

    ExternalProject_Add_Step(
        ${package}
        extract_archive
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
