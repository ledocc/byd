


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    set(steps
        GENERAL
        DOWNLOAD
        UPDATE
        CONFIGURE
        BUILD
        INSTALL
        TEST
        LOG)


    byd__EP__step__collect_steps_arguments(${package} "${steps}" arguments)
    byd__EP__step__log_EP_Add_command(${package} "${arguments}")

    ExternalProject_Add(
        ${package}
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
