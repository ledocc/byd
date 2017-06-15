


include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/custom_patch/enable.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    byd__EP__step__custom_patch__is_enable(${package} is_enable)
    if(NOT is_enable)
        return()
    endif()


    byd__EP__step__collect_steps_arguments(${package} CUSTOM_PATCH arguments)
    byd__EP__step__log_EP_Add_Step_command(${package} custom_patch "${arguments}")

    ExternalProject_Add_Step(
        ${package}
        custom_patch
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
