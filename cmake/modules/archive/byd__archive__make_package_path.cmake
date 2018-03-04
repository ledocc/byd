



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_hash str result)

    string(LENGTH "${str}" str_length)
    if(str_length EQUAL 0)
        byd__func__return_value("0")
        return()
    endif()

    string(SHA1 hash "${str}")
    byd__func__return(hash)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_dependencies_build_id package result)

    byd__package__collect_dependencies_abis(${package} abis)
    byd__archive__get_hash("${abis}" dependencies_build_id)
    byd__func__return(dependencies_build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_cmake_args_build_id result)

    byd__get_cmake_args_in_build_id(CMAKE_ARGS)

    foreach(arg IN LISTS CMAKE_ARGS)
        list(APPEND cmake_args "${arg}=${${arg}}")
    endforeach()

    byd__archive__get_hash("${cmake_args}" build_id)
    byd__func__return(build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_archive_root_dir result)

    cmut__system__get_distribution_name(distribution_name)
    set(root_dir "${distribution_name}")


    if (UNIX AND (NOT APPLE))
        cmut__system__get_distribution_version(distribution_version)
        set(root_dir "${root_dir}-${distribution_version}")
    endif()


    byd__func__return(root_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_archive_cmake_args_dir result)

    byd__archive__get_archive_root_dir(root_dir)
    set(output_dir "${root_dir}")

    byd__get_build_id(byd_build_id)
    set(output_dir "${output_dir}/byd-${byd_build_id}")

    byd__archive__get_cmake_args_build_id(cmake_args_build_id)
    set(output_dir "${output_dir}/${cmake_args_build_id}")

    byd__func__return(output_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_package_archive_output_dir package result)

    byd__archive__get_archive_cmake_args_dir(output_dir)

    byd__package__get_version(${package} package_version)
    set(output_dir "${output_dir}/${package}-${package_version}")

    byd__archive__get_dependencies_build_id(${package} dependencies_build_id)
    set(output_dir "${output_dir}/${dependencies_build_id}")

    byd__func__return(output_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__write_cmake_args_in_build_id)

    byd__get_cmake_args_in_build_id(CMAKE_ARGS)

    foreach(arg IN LISTS CMAKE_ARGS)
        string(APPEND cmake_args_in_build_id "${arg}=${${arg}}\n")
    endforeach()

    byd__archive__get_local_repository(repository)
    byd__archive__get_archive_cmake_args_dir(output_dir)

    set(path "${repository}/${output_dir}")

    if(NOT EXISTS ${path})
        cmut__utils__mkdir(${path})
    endif()
    file(WRITE "${path}/cmake_args.txt" ${cmake_args_in_build_id})

    cmut_info("")
    cmut_info( "[byd][archive] - archive root directory : \"${path}\"")
    cmut_debug("[byd][archive] - args :\n${cmake_args_in_build_id}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_package_archive_path package result)

    byd__archive__get_package_archive_output_dir(${package} output_dir)
    byd__func__return_value(${output_dir}/${package}.tar.xz)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__find_package_archive_path package result)

    byd__archive__get_local_repository(repository)
    byd__archive__get_local_package_archive_path(${package} package_path)

    set(path "${repository}/${package_path}")

    if(EXISTS "${path}")
        byd__func__return(path)
        cmut_debug("[byd][archive] - [${package}] : path found : ${path}")
        return()
    endif()

    byd__func__return_value("")
    cmut_debug("[byd][archive] - [${package}] : path not found : ${path}")

endfunction()
