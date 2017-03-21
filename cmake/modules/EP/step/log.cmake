


include("${CMUT_ROOT}/cmut_message.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##


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