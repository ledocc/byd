
include("${BYD_ROOT}/cmake/modules/private/byd__private__num_core_available.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__jobs)

    set(default_jobs "")

    set(jobs_from_env_var "$ENV{BYD__OPTION__JOBS}")
    if(jobs_from_env_var)
        set(default_jobs "${jobs_from_env_var}")
    else()
        cmut__system__get_num_core_available(default_jobs)
    endif()
    
    set(BYD__OPTION__JOBS ${default_jobs} CACHE STRING "Specifies the number of jobs to run simultaneously. default = num of logical core on the host")
    byd__private__set_num_core_available(${BYD__OPTION__JOBS})

    variable_watch(BYD__OPTION__JOBS byd__private__update_option_jobs)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
