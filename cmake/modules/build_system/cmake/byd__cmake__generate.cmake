


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
    if(DEFINED ${__variable})
        __byd__cmake__add_variable("${__list}" "${__variable}" "${${__variable}}")
    endif()
endmacro()

macro(__byd__cmake__add_variable __list __variable __value)
    # when __value is a list (like CMAKE_MODULE_PATH), we have to escaped each list separator to keep it unchanged until it is used in cmake command
    # invocation to configure the cmake based project that this script generate. We need 15 \ to protect this list all along the assignment of
    # the variable that store this list
    string(REPLACE ";" "\\\\\\\\\\\\\\\;" escaped_value "${__value}")
    list(APPEND ${__list} "-D${__variable}=${escaped_value}")
endmacro()

function(__byd__cmake__add_cmut_find_to_cmake_module_path)
    set(__cmut__find "${CMUT_ROOT}/find")
    if(NOT __cmut__find IN_LIST CMAKE_MODULE_PATH)
        set(CMAKE_MODULE_PATH "${__cmut__find}" "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
    endif()
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__cmake__generate_configure_cmake_args package)

    set(__property_name BYD__EP__CONFIGURE__CMAKE_ARGS__${package})

    set(__cmake__args)

    if(CMAKE_INSTALL_PREFIX)
        set(CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")
    endif()

    __byd__cmake__add_cmut_find_to_cmake_module_path()
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_MODULE_PATH)

    if (DEFINED CMAKE_TOOLCHAIN_FILE)
        __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_TOOLCHAIN_FILE)
    else()
        __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_C_COMPILER)
        __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_CXX_COMPILER)
    endif()

    __byd__cmake__add_variable_if_defined(__cmake_args BUILD_SHARED_LIBS)
    __byd__cmake__add_variable_if_defined(__cmake_args BUILD_TESTING)
    byd__package__get_install_dir(${package} install_dir)
    __byd__cmake__add_variable(           __cmake_args CMAKE_INSTALL_PREFIX "${install_dir}")
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_BUILD_TYPE)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_PREFIX_PATH)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_VERBOSE_MAKEFILE)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_INSTALL_RPATH)

    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_ARCHITECTURES)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_DEPLOYMENT_TARGET)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_OSX_SYSROOT)
    __byd__cmake__add_variable_if_defined(__cmake_args CMAKE_MACOSX_RPATH)

    byd__cmake__configure__get_arg(${package} user_define_args)
    byd__EP__set_package_argument(${package} CONFIGURE CMAKE_ARGS "${__cmake_args}" "${user_define_args}")
    byd__EP__set_package_argument(${package} CONFIGURE CMAKE_GENERATOR "${CMAKE_GENERATOR}")


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


    byd__build_system__default_test_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
