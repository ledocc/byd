
include("${BYD_ROOT}/cmake/modules/private/byd__private__num_core_available.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__jobs)

    cmut__system__get_num_core_available(num_core_available)

    byd__option__private__get_default("BYD__OPTION__JOBS" ${num_core_available} default_jobs)
    if(default_jobs STREQUAL "")
        set(default_jobs 1)
    endif()

    set(BYD__OPTION__JOBS
        ${default_jobs}
        CACHE
        STRING
        "Specifies the number of jobs to run simultaneously. default = num of logical core on the host"
        FORCE
        )

    byd__private__set_num_core_available(${BYD__OPTION__JOBS})
    variable_watch(BYD__OPTION__JOBS byd__private__update_option_jobs)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
