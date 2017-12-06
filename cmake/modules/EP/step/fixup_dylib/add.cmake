


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/fixup_dylib/enable.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    byd__EP__step__fixup_dylib__is_enable(${package} is_enable)
    if(NOT is_enable)
        return()
    endif()


    byd__EP__step__collect_steps_arguments(${package} FIXUP_DYLIB arguments)
    byd__EP__step__log_EP_Add_Step_command(${package} fixup_dylib "${arguments}")

    ExternalProject_Add_Step(
        ${package}
        fixup_dylib
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
