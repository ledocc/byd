


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")

include("${BYD_ROOT}/cmake/modules/build_system/autotool/byd__autotool__configure.cmake")
include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__collect_flags.cmake")
include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__default.cmake")
include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__inject_env_var.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__autotool__script__set_env_var_if_defined variable value)
    if(${value})
        byd__script__env__set("${variable}" "${${value}}")
    endif()
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__autotool__script__prepend_env_var variable value)
    byd__script__env__prepend("${variable}" "${value}")
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__autotool__script__prepend_env_var_if_defined variable value)
    if(${value})
        byd__script__env__prepend("${variable}" "${${value}}")
    endif()
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__autotool__get_source_dir package result)
    byd__package__get_source_dir(${package} source_dir)
    byd__package__get_source_sub_dir(${package} source_sub_dir)

    if(source_sub_dir)
        set(source_dir "${source_dir}/${source_sub_dir}")
    endif()

    byd__func__return(source_dir)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_update_command package)

    set(__property_name BYD__EP__UPDATE__UPDATE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)
    __byd__autotool__get_source_dir(${package} source_dir)


    byd__script__begin("${script_dir}/update.cmake")
        byd__build_system__inject_env_var_in_script(${package} UPDATE)
        byd__script__write("if(NOT EXISTS \"${source_dir}/configure\")")
        byd__script__command("${source_dir}/autogen.sh")
        byd__script__write("endif()")
    byd__script__end()


    byd__build_system__default_update_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    if(CMAKE_BUILD_TYPE)
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            list(APPEND configure_args --disable-release --enable-debug)
        else()
            list(APPEND configure_args --enable-release  --disable-debug)
        endif()
    endif()

    if(CMAKE_INSTALL_PREFIX)
        set(prefix_dir  "${CMAKE_INSTALL_PREFIX}")
        set(bin_dir     "${prefix_dir}/bin")
        set(lib_dir     "${prefix_dir}/lib")
        set(pkg1_dir    "${prefix_dir}/lib/pkgconfig")
        set(pkg2_dir    "${prefix_dir}/share/pkgconfig")
    endif()

    byd__build_system__collect_flags(C c_compile_flags c_include_flags c_link_flags)
    byd__build_system__collect_flags(CXX cxx_compile_flags cxx_include_flags cxx_link_flags)

    if(BUILD_SHARED_LIBS)
        list(APPEND configure_args --enable-shared --disable-static)
    else()
        list(APPEND configure_args --disable-shared --enable-static)
    endif()

    byd__package__get_install_dir(${package} install_dir)
    list(APPEND configure_args "--prefix=${install_dir}")

    if(CMAKE_CROSSCOMPILING)
        list(APPEND configure_args "--host=${CMAKE_CXX_COMPILER_TARGET}")
    endif()

    byd__autotool__configure__add_components_to_arg(${package})
    byd__autotool__configure__get_args(${package} custom_configure_args)


    byd__autotool__configure__get_configure_cmd(${package} configure_cmd)
    __byd__autotool__get_source_dir(${package} source_dir)
    set(command "${source_dir}/${configure_cmd}" "${configure_args}" "${custom_configure_args}")

    byd__script__begin("${script_dir}/configure.cmake")
        byd__build_system__inject_env_var_in_script(${package} CONFIGURE)
        __byd__autotool__script__set_env_var_if_defined("AR:PATH"      "CMAKE_AR")
        __byd__autotool__script__set_env_var_if_defined("AS:PATH"      "CMAKE_ASM_COMPILER")
        __byd__autotool__script__set_env_var_if_defined("LD:PATH"      "CMAKE_LINKER")
        __byd__autotool__script__set_env_var_if_defined("NM:PATH"      "CMAKE_NM")
        __byd__autotool__script__set_env_var_if_defined("OBJCOPY:PATH" "CMAKE_OBJCOPY")
        __byd__autotool__script__set_env_var_if_defined("RANLIB:PATH"  "CMAKE_RANLIB")
        __byd__autotool__script__set_env_var_if_defined("STRIP:PATH"   "CMAKE_STRIP")
#        __byd__autotool__script__set_env_var_if_defined("CPP:PATH"     "CMAKE_C_PREPROCESSOR")
        __byd__autotool__script__set_env_var_if_defined("CC:PATH"      "CMAKE_C_COMPILER")
        __byd__autotool__script__set_env_var_if_defined("CXX:PATH"     "CMAKE_CXX_COMPILER")

        __byd__autotool__script__prepend_env_var_if_defined("PATH:PATH"   "bin_dir")
        __byd__autotool__script__prepend_env_var_if_defined("LD_LIBRARY_PATH:PATH" "lib_dir")
        __byd__autotool__script__prepend_env_var_if_defined("PKG_CONFIG_PATH:PATH" "pkg1_dir")
        __byd__autotool__script__prepend_env_var_if_defined("PKG_CONFIG_PATH:PATH" "pkg2_dir")

#        __byd__autotool__script__prepend_env_var_if_defined("CPPFLAGS" "c_include_flags")
        __byd__autotool__script__set_env_var_if_defined("CPPFLAGS" "cxx_include_flags")

        __byd__autotool__script__set_env_var_if_defined("CFLAGS"   "c_compile_flags")
        __byd__autotool__script__set_env_var_if_defined("CXXFLAGS" "cxx_compile_flags")
        __byd__autotool__script__set_env_var_if_defined("LDFLAGS"  "cxx_link_flags")

        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_configure_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    byd__private__get_num_core_available(num_core)
    set(command make)
    if(CMAKE_VERBOSE_MAKEFILE)
        set(command ${command} VERBOSE=1)
    endif()
    byd__private__get_num_core_available(num_core)
    set(command ${command} -j${num_core})

    byd__script__begin("${script_dir}/build.cmake")
        byd__build_system__inject_env_var_in_script(${package} BUILD)
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_build_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    byd__private__get_num_core_available(num_core)
    set(command make install -j${num_core})


    byd__script__begin("${script_dir}/install.cmake")
        byd__build_system__inject_env_var_in_script(${package} INSTALL)
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_test_command package)

    cmut__utils__parse_arguments(
       byd__autotool__generate_test_command
        PARAM
        ""
        "TARGET"
        ""
        "${ARGN}"
        )

    set(TARGET test)
    if(PARAM_TARGET)
        set(TARGET ${PARAM_TARGET})
    endif()



    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)



    byd__private__get_num_core_available(num_core)
    set(command make ${TARGET} -j${num_core})


    byd__script__begin("${script_dir}/test.cmake")
        byd__build_system__inject_env_var_in_script(${package} TEST)
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_test_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
