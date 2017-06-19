
include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__provider__define_step_info)

    byd__EP__step__return_if_defined_or_define(BYD__EP__STEP__FIXUP_DYLIB__DEFINED)


    set(step_name FIXUP_DYLIB)

    byd__EP__step__set_parameter_source(${step_name} COMMAND           package)
    byd__EP__step__set_parameter_source(${step_name} COMMENT           default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDEES         package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDERS         package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DEPENDS           package)
    byd__EP__step__set_parameter_source(${step_name} BYPRODUCTS        package)
    byd__EP__step__set_parameter_source(${step_name} ALWAYS            package)
    byd__EP__step__set_parameter_source(${step_name} EXCLUDE_FROM_MAIN package)
    byd__EP__step__set_parameter_source(${step_name} WORKING_DIRECTORY package)
    byd__EP__step__set_parameter_source(${step_name} LOG               package_or_default)
    byd__EP__step__set_parameter_source(${step_name} USES_TERMINAL     package)


    byd__EP__set_default_argument(${step_name} COMMENT "Fixup shared library (.dylib) rpath")
    byd__EP__set_default_argument(${step_name} DEPENDEES "install")

#    if(BYD__EP__LOG)
        byd__EP__set_default_argument(${step_name} LOG ON)
#    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
