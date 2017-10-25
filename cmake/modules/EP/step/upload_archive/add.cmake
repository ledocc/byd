


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/step/collect_steps.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/upload_archive/enable.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider_add package)

    cmut_debug("byd__EP__step__provider_add ${package}")

    byd__EP__step__upload_archive__is_enable(${package} is_enable)
    if(NOT is_enable)
        return()
    endif()

    cmut_debug("byd__EP__step__provider_add ${package} pass")

    byd__EP__set_package_argument(${package} UPLOAD_ARCHIVE COMMENT "Upload \'${package}\' archive")

    byd__EP__step__collect_steps_arguments(${package} UPLOAD_ARCHIVE arguments)
    byd__EP__step__log_EP_Add_Step_command(${package} upload_archive "${arguments}")

    ExternalProject_Add_Step(
        ${package}
        upload_archive
        ${arguments}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
