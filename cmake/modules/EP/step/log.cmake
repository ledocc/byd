


include("${CMUT_ROOT}/cmut_message.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

set(__ENV_BYD__EP__DEBUG $ENV{BYD__EP__DEBUG})
if(__ENV_BYD__EP__DEBUG)
    set(BYD__EP__DEBUG 1)
endif()

function(byd__EP__step__debug message)

    if(NOT BYD__EP__DEBUG)
        return()
    endif()

    cmut_debug("[byd][EP][step] - ${message}")

endfunction()


function(byd__EP__step__log_EP_Add_Step_command package step arguments)

    byd__EP__step__log_EP_command("Add_Step" ${package} ${step} ${step} "${arguments}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__log_EP_Add_command package arguments)

    byd__EP__step__log_EP_command("Add" ${package} "standard" "" "${arguments}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__log_EP_command command package provider step arguments)

    cmut_debug("[byd][EP][${provider}] - [${package}] : ExternalProject_${command}(${package}")
    if(step)
        cmut_debug("[byd][EP][${provider}] - [${package}] :     ${step}")
    endif()
    foreach(argument IN LISTS arguments)
        cmut_debug("[byd][EP][${provider}] - [${package}] :     ${argument}")
    endforeach()
    cmut_debug("[byd][EP][${provider}] - [${package}] : )")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
