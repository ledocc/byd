

function(byd__option__private__get_default option_name default result)

    set(_from_env_var "$ENV{${option_name}}")
    if(DEFINED "${option_name}")
        set(default_value "${${option_name}}")
    elseif(NOT "${_from_env_var}" STREQUAL "")
        set(default_value "${_from_env_var}")
    else()
        set(default_value "${default}")
    endif()

    byd__func__return(default_value)

endfunction()
