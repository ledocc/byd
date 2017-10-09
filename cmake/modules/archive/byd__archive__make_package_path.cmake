


function(byd__archive__get_dependencies_build_id package result)

    byd__package__collect_dependencies_abis(${package} abis)


    string(LENGTH "${abis}" abis_length)
    if(abis_length EQUAL 0)
        byd__func__return_value("0")
        return()
    endif()



    string(SHA1 dependencies_build_id "${abis}")
    byd__func__return(dependencies_build_id)

endfunction()


function(byd__archive__get_package_archive_output_dir package result)

    byd__get_build_id(byd_build_id)
    byd__package__get_build_id(${package} package_build_id)
    if("${package_build_id}x" STREQUAL "x")
        cmut_error("[byd] - [${package}] : build_id is not defined !!!\npackage maintener have to call\nbyd__package__set_build_id(...) to define one")
    endif()

    byd__archive__get_dependencies_build_id(${package} dependencies_build_id)

    byd__func__return_value("${byd_build_id}/${package}/${package_build_id}/${dependencies_build_id}")

endfunction()

function(byd__archive__get_local_package_archive_path package result)

    byd__archive__get_package_archive_output_dir(${package} output_dir)
    byd__func__return_value(${output_dir}/${package}.tar.xz)


endfunction()



function(byd__archive__find_package_archive_path package result)

    byd__archive__get_repositories(repositories)
    byd__archive__get_local_package_archive_path(${package} package_path)

    foreach(repo IN LISTS repositories)

        set(path "${repo}/${package_path}")

        if(EXISTS "${path}")
            byd__func__return(path)
            cmut_debug("path found : ${path}")
            return()
        endif()

    endforeach()

    byd__func__return_value("")
    cmut_debug("path not found")

endfunction()
