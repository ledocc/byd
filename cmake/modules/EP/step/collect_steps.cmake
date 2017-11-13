


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")

include("${BYD_ROOT}/cmake/modules/EP/step/log.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##




function(byd__EP__step__found_step_argument package step parameter result)

    byd__EP__step__get_parameter_source(${step} ${parameter} source)
    byd__EP__step__debug("package=${package}, step=${step}, parameter=${parameter}, source=${source}")

    set(valid_source 0)
    if(source MATCHES "component")
        byd__EP__is_defined_component_argument(${package} ${step} ${parameter} is_defined)
        if(is_defined)
            byd__EP__get_component_argument(${package} ${step} ${parameter} argument)
            byd__func__return(argument)
            return()
        endif()

        set(valid_source 1)
    endif()

    if(source MATCHES "package")
        byd__EP__is_defined_package_argument(${package} ${step} ${parameter} is_defined)
        if(is_defined)
            byd__EP__get_package_argument(${package} ${step} ${parameter} argument)
            byd__func__return(argument)
            return()
        endif()

        set(valid_source 1)
    endif()

    if(source MATCHES "default")
        byd__EP__is_defined_default_argument(${step} ${parameter} is_defined)
        if(is_defined)
            byd__EP__get_default_argument(${step} ${parameter} argument)
            byd__func__return(argument)
            return()
        endif()

        set(valid_source 1)
    endif()

    if(NOT valid_source)
        cmut_fatal("[byd][EP] - invalid source for step=${step}, parameter=${parameter}, source=${source}")
    endif()

endfunction()

function(byd__EP__step__collect_step_arguments package step parameters result)

    set(arguments)

    foreach(parameter IN LISTS parameters)

        set(argument "NOT_DEFINED-argument")
        byd__EP__step__found_step_argument("${package}" "${step}" "${parameter}" argument)

        byd__EP__step__debug("package=${package}, step=${step}, parameter=${parameter}, argument=${argument}")

        if(NOT argument STREQUAL "NOT_DEFINED-argument")
            list(APPEND arguments "${parameter}" "${argument}")
        endif()

    endforeach()

    byd__func__return(arguments)

endfunction()


function(byd__EP__step__collect_steps_arguments package steps result)

    foreach(step IN LISTS steps)

        byd__EP__step__get_parameters(${step} parameters)
        byd__EP__step__collect_step_arguments(${package} ${step} "${parameters}" arguments)

        list(APPEND arguments_steps "${arguments}")

    endforeach()

    byd__func__return(arguments_steps)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
