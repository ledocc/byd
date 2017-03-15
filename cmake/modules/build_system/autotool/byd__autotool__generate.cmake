


include("${BYD_ROOT}/cmake/modules/package/byd__package__get_property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__error_if_property_is_defined.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__add_args package)

    byd__add_to_property(BYD__AUTOTOOL__CONFIGURE__ARGS__${package} ${ARGN})

endfunction()

function(byd__autotool__configure__get_configure_args package result)

    byd__get_property(BYD__AUTOTOOL__CONFIGURE__ARGS__${package} __result)
    set(${result} "${__result}" PARENT_SCOPE)

endfunction()


function(byd__autotool__configure__set_configure_cmd package)

    byd__set_property(BYD__AUTOTOOL__CONFIGURE__CONFIGURE_CMD__${package} ${ARGN})

endfunction()

function(byd__autotool__configure__get_final_configure_cmd package result)

    byd__is_property(BYD__AUTOTOOL__CONFIGURE__CONFIGURE_CMD__${package} is_custom_configure)
    if(is_custom_configure)
        byd__get_property(BYD__AUTOTOOL__CONFIGURE__CONFIGURE_CMD__${package} custom_configure)
        set(${result} ${custom_configure} PARENT_SCOPE)
    else()
        set(${result} configure PARENT_SCOPE)
    endif()

endfunction()

function(byd__autotool__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)



    if(CMAKE_BUILD_TYPE)
        string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_TYPE)
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            list(APPEND configure_args --disable-release --enable-debug)
        else()
            list(APPEND configure_args --enable-release  --disable-debug)
        endif()
    endif()

    if(CMAKE_INSTALL_PREFIX)
        set(prefix_dir  "${CMAKE_INSTALL_PREFIX}")
        set(include_dir "${prefix_dir}/include")
        set(lib_dir     "${prefix_dir}/lib")
        set(bin_dir     "${prefix_dir}/bin")
        set(pkg1_dir    "${prefix_dir}/lib/pkgconfig")
        set(pkg2_dir    "${prefix_dir}/share/pkgconfig")
    endif()

    byd__autotool__configure__get_configure_args(${package} configure_args)
    if(BUILD_SHARED_LIBS)
        list(APPEND configure_args --enable-shared --disable-static)
    else()
        list(APPEND configure_args --disable-shared --enable-static)
    endif()

    if(CMAKE_INSTALL_PREFIX)
        list(APPEND configure_args "--prefix=${CMAKE_INSTALL_PREFIX}")
    endif()


    byd__autotool__configure__get_final_configure_cmd(${package} configure_cmd)
    set(command ../${package}/${configure_cmd} "${configure_args}")

    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__add_run_command_or_abort_function()
        __byd__autotool__script__set_env_var_if_defined("AR:PATH"      "CMAKE_AR")
        __byd__autotool__script__set_env_var_if_defined("AS:PATH"      "CMAKE_ASM_COMPILER")
        __byd__autotool__script__set_env_var_if_defined("LD:PATH"      "CMAKE_LINKER")
        __byd__autotool__script__set_env_var_if_defined("NM:PATH"      "CMAKE_NM")
        __byd__autotool__script__set_env_var_if_defined("OBJCOPY:PATH" "CMAKE_OBJCOPY")
        __byd__autotool__script__set_env_var_if_defined("RANLIB:PATH"  "CMAKE_RANLIB")
        __byd__autotool__script__set_env_var_if_defined("STRIP:PATH"   "CMAKE_STRIP")
        __byd__autotool__script__set_env_var_if_defined("CPP:PATH"     "CMAKE_C_PREPROCESSOR")
        __byd__autotool__script__set_env_var_if_defined("CC:PATH"      "CMAKE_C_COMPILER}")
        __byd__autotool__script__set_env_var_if_defined("CXX:PATH"     "CMAKE_CXX_COMPILER}")

        __byd__autotool__script__prepend_env_var_if_defined("PATH:PATH"   "bin_dir")
        __byd__autotool__script__prepend_env_var_if_defined("PKG_CONFIG:PATH" "pkg1_dir")
        __byd__autotool__script__prepend_env_var_if_defined("PKG_CONFIG:PATH" "pkg2_dir")

        if(include_dir)
            __byd__autotool__script__prepend_env_var("CPPFLAGS:PATH" "-I${include_dir}")
        endif()

        __byd__autotool__script__prepend_env_var_if_defined("CFLAGS"   "CMAKE_C_FLAGS")
        __byd__autotool__script__prepend_env_var_if_defined("CFLAGS"   "CMAKE_C_FLAGS_${BUILD_TYPE}")

        __byd__autotool__script__prepend_env_var_if_defined("CXXFLAGS"   "CMAKE_CXX_FLAGS")
        __byd__autotool__script__prepend_env_var_if_defined("CXXFLAGS"   "CMAKE_CXX_FLAGS_${BUILD_TYPE}")

        if(lib_dir)
            __byd__autotool__script__prepend_env_var("LDFLAGS"   "-L${lib_dir}")
        endif()
        __byd__autotool__script__prepend_env_var_if_defined("LDFLAGS"   "CMAKE_EXE_LINKER_FLAGS")
        __byd__autotool__script__prepend_env_var_if_defined("LDFLAGS"   "CMAKE_EXE_LINKER_FLAGS_${BUILD_TYPE}")

        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/configure.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    set(command make -j${BYD__BUILD__NUM_CORE_AVAILABLE})


    byd__script__begin("${script_dir}/build.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/build.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    set(command make install -j${BYD__BUILD__NUM_CORE_AVAILABLE})


    byd__script__begin("${script_dir}/install.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/install.cmake")

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



    set(command make ${TARGET} -j${BYD__BUILD__NUM_CORE_AVAILABLE})


    byd__script__begin("${script_dir}/test.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/test.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
