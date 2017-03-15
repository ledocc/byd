


include("${BYD_ROOT}/cmake/modules/build_system/BoostBuild/compiler_ID_to_toolset.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__get_property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__error_if_property_is_defined.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")




##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__build__add_args package)

    byd__add_to_property(BYD__BOOSTBUILD__BUILD__ARGS__${package} "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__build__get_args package result)

    byd__get_property(BYD__BOOSTBUILD__BUILD__ARGS__${package} __result)
    set(${result} "${__result}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__BoostBuild__set_build_command_line package)

    byd__add_to_property(BYD__BOOSTBUILD__BUILD_COMMAND_LINE__${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__BoostBuild__get_build_command_line package result)

    byd__get_property(BYD__BOOSTBUILD__BUILD_COMMAND_LINE__${package} __result)
    set(${result} "${__result}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)



    if(WIN32)
        set(configure_cmd bootstrap.bat)
    else()
        set(configure_cmd ./bootstrap.sh)
    endif()
    set(command ${configure_cmd})


    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/configure.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)



    set(build_args "")

    list(APPEND build_args "toolset=${BOOST_TOOLSET}")

    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        list(APPEND build_args "variant=debug")
    else()
        list(APPEND build_args "variant=release")
    endif()


    if(BUILD_SHARED_LIBS)
        list(APPEND build_args "link=shared")
    else()
        list(APPEND build_args "link=static")
    endif()


    if(CMAKE_INSTALL_PREFIX)
        list(APPEND build_args "--prefix=${CMAKE_INSTALL_PREFIX}")
    endif()


    list(APPEND build_args "--build_type=minimal")
    list(APPEND build_args "--build_dir=../${package}-build")
    list(APPEND build_args "--layout=tagged")


    if(CMAKE_VERBOSE_MAKEFILE)
        list(APPEND build_args "-d2")
    else()
        list(APPEND build_args "-d0")
    endif()


    byd__BoostBuild__build__get_args(${package} build_args_${package})


    if(WIN32)
        set(build_cmd b2)
    else()
        set(build_cmd ./b2)
    endif()
    set(command ${build_cmd} "${build_args}" "${build_args_${package}}")
    __byd__BoostBuild__set_build_command_line(${package} "${command}")



    byd__script__begin("${script_dir}/build.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/build.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)


    __byd__BoostBuild__get_build_command_line(${package} command)
    list(APPEND command install)

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/install.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
