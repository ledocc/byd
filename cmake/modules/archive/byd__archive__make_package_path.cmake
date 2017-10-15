


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

function(byd__archive__get_cmake_args_build_id package result)

    set(CMAKE_ARGS
        CMAKE_C_COMPILER
        CMAKE_CXX_COMPILER
        BUILD_SHARED_LIBS
        CMAKE_BUILD_TYPE
        CMAKE_OSX_ARCHITECTURES
        CMAKE_OSX_DEPLOYMENT_TARGET
        CMAKE_OSX_SYSROOT
        )

    foreach(arg IN LISTS CMAKE_ARGS)
        list(APPEND cmake_args "${arg}=${${arg}}")
    endforeach()

    byd__archive__get_hash("${cmake_args}" build_id)
    byd__func__return(build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_package_archive_output_dir package result)

    byd__get_build_id(byd_build_id)

    byd__archive__get_cmake_args_build_id(${package} cmake_args_build_id)

    byd__package__get_version(${package} package_version)

    byd__archive__get_dependencies_build_id(${package} dependencies_build_id)

    byd__func__return_value("${byd_build_id}/${cmake_args_build_id}/${package}/${package_version}/${dependencies_build_id}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_package_archive_path package result)

    byd__archive__get_package_archive_output_dir(${package} output_dir)
    byd__func__return_value(${output_dir}/${package}.tar.xz)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

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
