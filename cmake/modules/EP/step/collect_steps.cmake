


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__collect_step_arguments package step parameters result)

    set(arguments "")

    foreach(parameter IN LISTS parameters)
        byd__EP__step__get_parameter_source(${step} ${parameter} source)

        if(source STREQUAL "package")
            byd__EP__is_defined_package_argument(${package} ${step} ${parameter} is_defined)
            byd__EP__get_package_argument(${package} ${step} ${parameter} argument)
        elseif(source STREQUAL "default")
            byd__EP__is_defined_default_argument(${step} ${parameter} is_defined)
            byd__EP__get_default_argument(${step} ${parameter} argument)
        elseif(source STREQUAL "package_or_default")
            byd__EP__is_defined_package_or_default_argument(${package} ${step} ${parameter} is_defined)
            byd__EP__get_package_or_default_argument(${package} ${step} ${parameter} argument)
        else()
            cmut_fatal("[byd][EP] - invalid source for step=${step}, parameter=${parameter}, source=${source}")
        endif()

#        cmut_debug("[byd][EP] - step=${step}, parameter=${parameter}, source=${source}, is_defined=${is_defined}, argument=${argument}")

        if(is_defined)
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
