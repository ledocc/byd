


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/byd__package_repositories.cmake")



function(byd__private__find_package_directory package result)

    byd__package__split_package_component_name(${package} package_name component_name)

    cmut_debug("[byd] - looking for ${package_name}")


    byd__get_package_repositories(repositories)
    list(APPEND repositories "${BYD_ROOT}/packages")


    set(package_dir "")

    foreach(dir IN LISTS repositories)
        cmut_debug("[byd] - test ${dir}/${package_name}")

        file(GLOB glob_result
            LIST_DIRECTORIES true
            RELATIVE ${dir}
            "${dir}/*"
            )

        if(package_name IN_LIST glob_result)
            set(package_dir "${dir}/${package_name}")
            break()
        endif()

    endforeach()


    if(package_dir)
        byd__func__return(package_dir)
    else()
        cmut_fatal("[byd] - [${package_name}] : info directory not found.")
    endif()

endfunction()
