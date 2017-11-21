


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")

include("${BYD_ROOT}/cmake/modules/build_system/BoostBuild/compiler_ID_to_toolset.cmake")
include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__default.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__build__add_args package)

    byd__func__add_to_property(BYD__BOOSTBUILD__BUILD__ARGS__${package} "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__build__get_args package result)

    byd__func__get_property(BYD__BOOSTBUILD__BUILD__ARGS__${package} __result)
    byd__func__return(__result)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__BoostBuild__set_build_command_line package)

    byd__func__add_to_property(BYD__BOOSTBUILD__BUILD_COMMAND_LINE__${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__BoostBuild__get_build_command_line package result)

    byd__func__get_property(BYD__BOOSTBUILD__BUILD_COMMAND_LINE__${package} __result)
    byd__func__return(__result)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__BoostBuild__script__generate_user_config_jam)

    if(ANDROID)

        if(BOOST_TOOLSET STREQUAL "clang")
            if(CMAKE_CXX_COMPILER_TARGET)
                set(compile_flags "${compile_flags} --target=${CMAKE_CXX_COMPILER_TARGET}")
            endif()
            if(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN)
                set(compile_flags "${compile_flags} --gcc-toolchain=${CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN}")
            endif()
        endif()
        if(CMAKE_SYSROOT)
            set(compile_flags "${compile_flags} --sysroot=${CMAKE_SYSROOT}")
        endif()

        if(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES)
            foreach(include_dir ${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES})
                set(compile_flags "${compile_flags} -isystem ${include_dir}")
            endforeach()
        endif()

    endif()



    byd__script__write("using ${BOOST_TOOLSET_NAME}")
    byd__script__write(":")
    if(MSVC AND BOOST_TOOLSET_VERSION)
        byd__script__write("${BOOST_TOOLSET_VERSION}")
    elseif(ANDROID)
        byd__script__write("android")
    else()
        byd__script__write("${CMAKE_CXX_COMPILER_VERSION}")
    endif()
    byd__script__write(":")
    byd__script__write("\"${CMAKE_CXX_COMPILER}\"")
    byd__script__write(":")
    if(ANDROID)
        byd__script__write("<architecture>\"${CMAKE_ANDROID_ARCH_ABI}\"")
        byd__script__write("<archiver>\"${CMAKE_AR}\"")
        byd__script__write("<linker>\"${CMAKE_LINKER}\"")
    endif()
    byd__script__write("<cflags>\"${CMAKE_C_FLAGS}\"")
    byd__script__write("<cxxflags>\"${CMAKE_CXX_FLAGS}\"")
    byd__script__write("<compileflags>\"${compile_flags}\"")
    byd__script__write("<linkflags>\"${compile_flags}\"")
    byd__script__write("<linkflags>\"${CMAKE_EXE_LINKER_FLAGS}\"")
    byd__script__write(";")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_build_dir(${package} build_dir)
    byd__package__get_source_dir(${package} source_dir)


    if(WIN32)
        set(configure_cmd ${source_dir}/bootstrap.bat)
    else()
        set(configure_cmd ${source_dir}/bootstrap.sh)
    endif()
    set(command ${configure_cmd})


    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__env__unset("CC")
        byd__script__env__unset("CXX")
        byd__script__env__unset("RC")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_configure_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_build_dir(${package} build_dir)
    byd__package__get_install_dir(${package} install_dir)



    set(build_args "")

    set(user_config_jam_file "user-config.jam")
    set(user_config_jam_path "${script_dir}/${user_config_jam_file}")
    byd__script__begin("${user_config_jam_path}")
        __byd__BoostBuild__script__generate_user_config_jam()
    byd__script__end()

    list(APPEND build_args "--user-config=${user_config_jam_path}")

    if(ANDROID)
        list(APPEND build_args "target-os=android")
    endif()

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

    list(APPEND build_args "--prefix=${install_dir}")
    list(APPEND build_args "--debug-configuration")
    list(APPEND build_args "--build_type=minimal")
    list(APPEND build_args "--build_dir=../${package}-build")
    list(APPEND build_args "--layout=tagged")


    if(CMAKE_VERBOSE_MAKEFILE)
        list(APPEND build_args "-d2")
    else()
        list(APPEND build_args "-d0")
    endif()


    byd__BoostBuild__build__get_args(${package} build_args_${package})


    byd__package__get_source_dir(${package} source_dir)
    set(build_cmd ${source_dir}/b2)

    byd__private__get_num_core_available(num_core)
    set(command_mv_user_config_jam ${CMAKE_COMMAND} -E copy "${user_config_jam_path}" "${build_dir}/${user_config_jam_file}")
    set(command ${build_cmd} -j${num_core} "${build_args}" "${build_args_${package}}")
    __byd__BoostBuild__set_build_command_line(${package} "${command}")



    byd__script__begin("${script_dir}/build.cmake")
#        byd__script__command("${command_mv_user_config_jam}")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_build_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)


    __byd__BoostBuild__get_build_command_line(${package} command)
    list(APPEND command install)

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__BoostBuild__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})
    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)



    __byd__BoostBuild__get_build_command_line(${package} command)

    byd__script__begin("${script_dir}/test.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__EP__set_package_argument(${package} TEST TEST_COMMAND "${CMAKE_COMMAND}" -E chdir "${source_dir}/status" "${CMAKE_COMMAND}" -P "${script_dir}/test.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
