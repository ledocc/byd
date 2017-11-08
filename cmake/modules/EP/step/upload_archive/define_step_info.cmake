
include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider__define_step_info)

    byd__EP__step__return_if_defined_or_define(BYD__EP__STEP__UPLOAD_ARCHIVE__DEFINED)


    set(step_name UPLOAD_ARCHIVE)

    byd__EP__step__set_parameter_source(${step_name} COMMAND           package)
    byd__EP__step__set_parameter_source(${step_name} COMMENT           package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDEES         package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDERS         package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDS           package)
    byd__EP__step__set_parameter_source(${step_name} BYPRODUCTS        package)
    byd__EP__step__set_parameter_source(${step_name} ALWAYS            package)
    byd__EP__step__set_parameter_source(${step_name} EXCLUDE_FROM_MAIN package)
    byd__EP__step__set_parameter_source(${step_name} WORKING_DIRECTORY package)
    byd__EP__step__set_parameter_source(${step_name} LOG               package_or_default)
    byd__EP__step__set_parameter_source(${step_name} USES_TERMINAL     package)


    byd__EP__set_default_argument(${step_name} COMMENT "Create reusable archive of this build")
    byd__EP__set_default_argument(${step_name} DEPENDEES "extract_archive")

    byd__EP__set_default_argument(${step_name} LOG ${BYD__OPTION__LOG_STEP})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
