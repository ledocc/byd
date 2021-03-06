



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_dependencies_build_id package result)

    byd__package__collect_dependencies_abis(${package} abis)
    byd__hashtag__compute_hashtag("${abis}" dependencies_build_id)
    byd__func__return(dependencies_build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__collect_cmake_args_build_id result)

    byd__get_cmake_args_in_build_id(CMAKE_ARGS)

    foreach(arg IN LISTS CMAKE_ARGS)
        list(APPEND cmake_args "${arg}=${${arg}}")
    endforeach()

    byd__func__return(cmake_args)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_cmake_args_build_id result)

    byd__archive__collect_cmake_args_build_id( cmake_args )
    byd__hashtag__compute_hashtag("${cmake_args}" build_id)
    byd__func__return(build_id)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_cmake_args_dir result)

    byd__archive__get_or_detect_system_id(system_id)
    set(output_dir "${system_id}")

    byd__get_build_id(byd_build_id)
    set(output_dir "${output_dir}/byd-${byd_build_id}")

    byd__archive__get_cmake_args_build_id(cmake_args_build_id)
    set(output_dir "${output_dir}/${cmake_args_build_id}")

    byd__func__return(output_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_cmake_args_path result)

    byd__archive__get_cmake_args_dir( cmake_args_dir )
    byd__func__return_value( "${cmake_args_dir}/cmake_args.txt" )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_package_archive_output_dir package result)

    byd__archive__get_cmake_args_dir(output_dir)

    byd__package__get_version(${package} package_version)
    set(output_dir "${output_dir}/${package}-${package_version}")

    byd__archive__get_dependencies_build_id(${package} dependencies_build_id)
    set(output_dir "${output_dir}/${dependencies_build_id}")

    byd__func__return(output_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__write_cmake_args_in_build_id)

    byd__archive__collect_cmake_args_build_id( cmake_args_build_id )

    foreach(arg IN LISTS cmake_args_build_id)
        string(APPEND cmake_args_in_build_id "${arg}\n")
    endforeach()

    byd__archive__get_local_cmake_args_path( cmake_args_path )
    get_filename_component( cmake_args_dir "${cmake_args_path}" DIRECTORY )

    if( NOT EXISTS "${cmake_args_dir}" )
        cmut__utils__mkdir( "${cmake_args_dir}" )
    endif()
    file(WRITE "${cmake_args_path}" ${cmake_args_in_build_id})

    cmut_info( "" )
    cmut_info( "[byd][archive] - archive root directory : \"${cmake_args_dir}\"")
    cmut_debug("[byd][archive] - args :\n${cmake_args_in_build_id}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__write_dependencies_id package)

    byd__package__collect_dependencies_abis(${package} abis)

    foreach(abi IN LISTS abis)
        string(APPEND dependencies_id "${abi}\n")
    endforeach()

    byd__archive__get_local_repository( repository )
    byd__archive__get_package_archive_output_dir( ${package} output_dir )

    set(output_dir "${repository}/${output_dir}")
    if( NOT EXISTS "${output_dir}" )
        cmut__utils__mkdir( "${output_dir}" )
    endif()
    file(WRITE "${output_dir}/dependencies.txt" ${dependencies_id})

    cmut_info( "" )
    cmut_info( "[byd][archive][${package}] - archive directory : \"${output_dir}\"")
    cmut_debug("[byd][archive][${package}] - dependencies :\n${dependencies_id}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_package_archive_path package result)

    byd__archive__get_package_archive_output_dir( ${package} output_dir )
    byd__func__return_value( "${output_dir}/${package}.tar.xz" )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__get_local_cmake_args_path result)

    byd__archive__get_local_repository( repository )
    byd__archive__get_cmake_args_path( cmake_args_path )

    byd__func__return_value( "${repository}/${cmake_args_path}" )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__archive__find_package_archive_path package result)

    byd__archive__get_local_repository(repository)
    byd__archive__get_package_archive_path(${package} package_path)

    set(path "${repository}/${package_path}")

    if(EXISTS "${path}")
        byd__func__return(path)
        cmut_debug("[byd][archive] - [${package}] : path found : ${path}")
        return()
    endif()

    byd__func__return_value("")
    cmut_debug("[byd][archive] - [${package}] : path not found : ${path}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
