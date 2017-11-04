


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/byd__package_repositories.cmake")



function(byd__private__find_package_directory package result)

    cmut_debug("[byd] - look for ${package}")


    byd__get_package_repositories(repositories)
    list(APPEND repositories "${BYD_ROOT}/packages")


    set(package_dir "")

    foreach(dir IN LISTS repositories)
        cmut_debug("[byd] - test ${dir}/${package}")

        file(GLOB glob_result
            LIST_DIRECTORIES true
            RELATIVE ${dir}
            "${dir}/*"
            )

        if(package IN_LIST glob_result)
            set(package_dir "${dir}/${package}")
            break()
        endif()

    endforeach()


    if(package_dir)
        byd__func__return(package_dir)
    else()
        cmut_fatal("[byd] - [${package}] : info directory not found.")
    endif()

endfunction()
