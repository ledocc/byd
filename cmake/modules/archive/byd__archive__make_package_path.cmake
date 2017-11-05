


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

function(__byd__archive__add_cmake_args_build_id args variable )

    if(NOT DEFINED ${variable})
        return()
    endif()

    list(APPEND ${args} ${variable})
    set(${args} "${${args}}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_cmake_args_build_id package result)

    set(CMAKE_ARGS
        BUILD_SHARED_LIBS
        CMAKE_BUILD_TYPE
        CMAKE_C_COMPILER
        CMAKE_C_COMPILER_AR
        CMAKE_C_COMPILER_RANLIB
        CMAKE_C_FLAGS
        CMAKE_CXX_COMPILER
        CMAKE_CXX_COMPILER_AR
        CMAKE_CXX_COMPILER_RANLIB
        CMAKE_CXX_FLAGS
        CMAKE_EXE_LINKER_FLAGS
        CMAKE_LINKER
        CMAKE_MODULE_LINKER_FLAGS
        CMAKE_OSX_ARCHITECTURES
        CMAKE_OSX_DEPLOYMENT_TARGET
        CMAKE_OSX_SYSROOT
        CMAKE_SHARED_LINKER_FLAGS
        CMAKE_STATIC_LINKER_FLAGS
        )

    if (NOT CMAKE_BUILD_TYPE STREQUAL "")
        string(TOUPPER ${CMAKE_BUILD_TYPE} buildType)
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_C_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_CXX_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_EXE_LINKER_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_MODULE_LINKER_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_SHARED_LINKER_FLAGS_${buildType})
    endif()

    foreach(arg IN LISTS CMAKE_ARGS)
        list(APPEND cmake_args "${arg}=${${arg}}")
    endforeach()

    byd__archive__get_hash("${cmake_args}" build_id)
    byd__func__return(build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_archive_root_dir result)

    cmut__system__get_distribution_name(distribution_name)
    cmut__system__get_distribution_version(distribution_version)
    set(root_dir "${distribution_name}-${distribution_version}")

    byd__func__return(root_dir)

endfunction()

function(byd__archive__get_package_archive_output_dir package result)

    byd__archive__get_archive_root_dir(root_dir)
    set(output_dir "${root_dir}")

    byd__get_build_id(byd_build_id)
    set(output_dir "${output_dir}/byd-${byd_build_id}")

    byd__archive__get_cmake_args_build_id(${package} cmake_args_build_id)
    set(output_dir "${output_dir}/${cmake_args_build_id}")

    byd__package__get_version(${package} package_version)
    set(output_dir "${output_dir}/${package}-${package_version}")

    byd__archive__get_dependencies_build_id(${package} dependencies_build_id)
    set(output_dir "${output_dir}/${dependencies_build_id}")

    byd__func__return(output_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_package_archive_path package result)

    byd__archive__get_package_archive_output_dir(${package} output_dir)
    byd__func__return_value(${output_dir}/${package}.tar.xz)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__find_package_archive_path package result)

    byd__archive__get_local_repository(repositories)
    byd__archive__get_local_package_archive_path(${package} package_path)

    foreach(repo IN LISTS repositories)

        set(path "${repo}/${package_path}")

        if(EXISTS "${path}")
            byd__func__return(path)
            cmut_debug("[byd][archive] - [${package}] : path found : ${path}")
            return()
        endif()

    endforeach()

    byd__func__return_value("")
    cmut_debug("[byd][archive] - [${package}] : path not found")

endfunction()
