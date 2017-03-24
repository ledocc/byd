


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")

include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__default.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__cmake__get_cmake_build_args result)
    set(__args)
    if(${CMAKE_MAKE_PROGRAM} MATCHES ".*/make$")
        byd__private__get_num_core_available(num_core)
        set(__args -- -j${num_core})
    endif()
    byd__func__return(__args)
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
        set(CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")
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


    byd__func__add_to_property(${__property_name} "${__cmake_args}")


    cmut_debug("[byd][cmake] - [${package}] : cmake_args :")
    byd__EP__get_package_argument(${package} CONFIGURE CMAKE_ARGS cmake_args)
    foreach(arg IN LISTS cmake_args)
        cmut_debug("[byd][cmake] - [${package}] :     ${arg}")
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . ${__build_options})


    byd__script__begin("${script_dir}/build.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_build_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . --target install ${__build_options})

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    __byd__cmake__get_cmake_build_args(__build_options)
    set(command "${CMAKE_COMMAND}" --build . --target test ${__build_options})

    byd__script__begin("${script_dir}/test.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
