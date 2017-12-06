
include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider__define_step_info)

    byd__EP__step__return_if_defined_or_define(BYD__EP__STEP__CUSTOM_PATCH__DEFINED)


    set(step_name CUSTOM_PATCH)

    byd__EP__step__set_parameter_source(${step_name} COMMAND           component_or_package)
    byd__EP__step__set_parameter_source(${step_name} COMMENT           default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDEES         component_or_package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDERS         component_or_package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDS           component_or_package)
    byd__EP__step__set_parameter_source(${step_name} BYPRODUCTS        component_or_package)
    byd__EP__step__set_parameter_source(${step_name} ALWAYS            component_or_package)
    byd__EP__step__set_parameter_source(${step_name} EXCLUDE_FROM_MAIN component_or_package)
    byd__EP__step__set_parameter_source(${step_name} WORKING_DIRECTORY component_or_package)
    byd__EP__step__set_parameter_source(${step_name} LOG               component_or_package_or_default)
    byd__EP__step__set_parameter_source(${step_name} USES_TERMINAL     component_or_package)


    byd__EP__set_default_argument(${step_name} COMMENT "Apply custom patch")
    byd__EP__set_default_argument(${step_name} DEPENDEES "update")
    byd__EP__set_default_argument(${step_name} DEPENDERS "configure")

    byd__EP__set_default_argument(${step_name} LOG ${BYD__OPTION__LOG_STEP})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
