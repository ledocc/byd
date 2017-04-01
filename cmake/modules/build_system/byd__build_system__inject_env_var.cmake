##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__get_injected_env_var_list package step result)

    byd__func__get_property(BYD__BUILD_SYSTEM__${step}__ENV_VAR__${package} variables)
    byd__func__return(variables)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__get_injected_env_var package step variable result)

    byd__func__get_property(BYD__BUILD_SYSTEM__${step}__ENV_VAR__${variable}__${package} value)
    byd__func__return(value)

endfunction()


function(byd__build_system__inject_env_var_in_script package step)

    byd__build_system__get_injected_env_var_list(${package} ${step} variables)

    foreach(variable IN LISTS variables)
        byd__build_system__get_injected_env_var(${package} ${step} ${variable} value)
        byd__script__env__set(${variable} ${value})
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__inject_env_var package step variable value)

    byd__func__add_to_property(BYD__BUILD_SYSTEM__${step}__ENV_VAR__${package} ${variable})
    byd__func__set_property(BYD__BUILD_SYSTEM__${step}__ENV_VAR__${variable}__${package} ${value})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
