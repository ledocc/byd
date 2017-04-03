
include("${BYD_ROOT}/cmake/modules/byd__prefix.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__prefix)

    set(default_prefix "")

    set(prefix_from_env_var "$ENV{BYD__OPTION__PREFIX}")
    if(prefix_from_env_var)
        set(default_prefix "${prefix_from_env_var}")
    endif()
    
    set(BYD__OPTION__PREFIX "${default_prefix}" CACHE STRING "Specifies the path where packages are build. Usefull on Windows where path have limited length.")
    file(TO_CMAKE_PATH "${BYD__OPTION__PREFIX}" BYD__OPTION__PREFIX_CMAKE_PATH)
    byd__set_prefix("${BYD__OPTION__PREFIX_CMAKE_PATH}")

    variable_watch(BYD__OPTION__PREFIX byd__private__update_option_prefix)

endfunction()


function(byd__private__update_option_prefix variable access value current_list_file stack)

    cmut__variable_watch__log_arguments("${variable}" "${access}" "${value}" "${current_list_file}" "${stack}")

    if(access STREQUAL "MODIFIED_ACCESS")
        file(TO_CMAKE_PATH "${value}" value_CMAKE_PATH)
        byd__set_prefix("${value_CMAKE_PATH}")
    endif()

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
