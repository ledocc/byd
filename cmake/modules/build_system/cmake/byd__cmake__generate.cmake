


include("${BYD_ROOT}/cmake/modules/package/byd__package__get_property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__error_if_property_is_defined.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__cmake__get_cmake_build_args args)
    set(__args)
    if(${CMAKE_MAKE_PROGRAM} MATCHES ".*/make$")
        set(__args -- -j${BYD__BUILD__NUM_CORE_AVAILABLE})
    endif()
    set(${args} "${__args}" PARENT_SCOPE)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__cmake__add_variable_if_defined __list __variable)
    if(${__variable})
        list(APPEND ${__list} "-D${__variable}=${${__variable}}")
    endif()
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_configure_cmake_args package)

    set(__property_name BYD__EP__CONFIGURE__CMAKE_ARGS__${package})

    set(__cmake__args)

    if(CMAKE_INSTALL_PREFIX)
        set(CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}/lib")
    endif()

    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_C_COMPILER)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_CXX_COMPILER)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_TOOLCHAIN_FILE)

    __byd__cmake__add_variable_if_defined(__cmake_args BUILD_SHARED_LIBS)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_INSTALL_PREFIX)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_BUILD_TYPE)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_PREFIX_PATH)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_VERBOSE_MAKEFILE)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_INSTALL_RPATH)

    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_ARCHITECTURES)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_DEPLOYMENT_TARGET)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_SYSROOT)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_MACOSX_RPATH)

    cmut_debug("__cmake_args = ${__cmake_args}")
    byd__add_to_property(${__property_name} "${__cmake_args}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . ${__build_options})


    byd__script__begin("${script_dir}/build.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/build.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . --target install ${__build_options})

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/install.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . --target test ${__build_options})

    byd__script__begin("${script_dir}/test.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "${script_dir}/test.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
