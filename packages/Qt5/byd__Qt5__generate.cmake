


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__Qt5__script__add_env_var)

    if(WIN32)
        set(LIBRARY_TO_LOAD_PATH bin)
        set(RUNTIME_PATH_ENV_VAR PATH)
    elseif(UNIX)
        set(LIBRARY_TO_LOAD_PATH lib)
        if(APPLE)
            set(RUNTIME_PATH_ENV_VAR DYLD_FALLBACK_LIBRARY_PATH)
        else()
            set(RUNTIME_PATH_ENV_VAR LD_LIBRARY_PATH)
        endif()
    endif()

    if(prefix)
        byd__script__env__prepend(${RUNTIME_PATH_ENV_VAR}:PATH "${prefix}/${LIBRARY_TO_LOAD_PATH}")
        byd__script__env__prepend(INCLUDE "${prefix}/include")
        byd__script__env__prepend(LIB "${prefix}/lib")
        byd__script__env__prepend(PKG_CONFIG_PATH "${prefix}/lib/pkgconfig")
        byd__script__env__prepend(PKG_CONFIG_PATH "${prefix}/share/pkgconfig")
    endif()

    if(WIN32)
        byd__package__get_source_dir(${package} source_dir)
        byd__script__env__prepend(${RUNTIME_PATH_ENV_VAR}:PATH "${source_dir}/qtbase/bin")
        byd__script__env__prepend(${RUNTIME_PATH_ENV_VAR}:PATH "${source_dir}/gnuwin32/bin")
    endif()

endmacro()


function(__byd__Qt5__get_platform_compiler result)
    if(APPLE)
        if(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
            set(mkspec macx-clang)
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            set(mkspec macx-g++)
        endif()
    elseif(UNIX)
        if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
            set(mkspec linux-clang)
            if(CMAKE_CXX_FLAGS MATCHES ".*-stdlib=libc++.*")
                set(mkspec ${mkspec}-libc++)
            endif()
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            set(mkspec linux-g++)
        endif()
    elseif(WIN32)
        if(MSVC12)
            set(mkspec win32-msvc2013)
        elseif(MSVC14)
            if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                set(mkspec win32-clang-msvc2015)
            else()
                set(mkspec win32-msvc2015)
            endif()
        endif()
    endif()

    if(NOT mkspec)
        cmut_fatal("[byd - [Qt5] : platform/compiler not supported by byd-Qt5 script")
        return()
    endif()

    byd__func__return(mkspec)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__configure__add_args package)

    byd__func__add_to_property(BYD__QT5__CONFIGURE__ARGS__${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__configure__get_args package result)

    byd__func__get_property(BYD__QT5__CONFIGURE__ARGS__${package} __result)
    byd__func__return(__result)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__configure__add_arg_if_dependency_is_added package dependency)

    byd__package__is_added(${dependency} is_added)
    if(is_added)
        byd__Qt5__configure__add_args(-${dependency})
    else()
        byd__Qt5__configure__add_args(-no-${dependency})
    endif()

endfunction()

function(byd__Qt5__configure__use_open_source package)
    byd__Qt5__configure__add_args(${package} -opensource -confirm-license)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)

    if(CMAKE_INSTALL_PREFIX)
        set(prefix ${CMAKE_INSTALL_PREFIX})
        if(NOT IS_ABSOLUTE "${CMAKE_INSTALL_PREFIX}")
            set(prefix "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX}")
        endif()
    endif()



    set(configure_arg)
    if(prefix)
        list(APPEND configure_arg "-prefix" "${prefix}")
    endif()

    if(CMAKE_BUILD_TYPE STREQUAL Debug)
        list(APPEND configure_arg "-debug" "-qml-debug")
    else()
        list(APPEND configure_arg "-release" "-no-qml-debug")
    endif()

    __byd__Qt5__get_platform_compiler(platform_compiler)
    list(APPEND configure_arg "-platform" "${platform_compiler}")

    # QtWebEngine is not supported in static mode, so always build in shared mode
    #cmut_EP_add_config_arg_if(BUILD_SHARED_LIBS "-shared" "-static")
    list(APPEND configure_arg "-shared")
    list(APPEND configure_arg "-largefile")
    list(APPEND configure_arg "-accessibility")

    list(APPEND configure_arg "-make" "tests")
    list(APPEND configure_arg "-nomake" "examples")


    set(configure_cmd "../Qt5/configure")
    if(WIN32)
        set(configure_cmd "${configure_cmd}.bat")
    endif()

    byd__Qt5__configure__get_args(${package} custom_configure_args)
    set(command "${configure_cmd}" "${configure_arg}" "${custom_configure_args}")


    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__add_run_command_or_abort_function()

        __byd__Qt5__script__add_env_var()

        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_configure_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)


    if(UNIX)
        byd__private__get_num_core_available(num_core)
        set(command make -j${num_core})
    elseif(WIN32 AND MSVC)
        set(command nmake)
    endif()

    byd__script__begin("${script_dir}/build.cmake")
        byd__script__add_run_command_or_abort_function()
        __byd__Qt5__script__add_env_var()
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_build_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)



    if(UNIX)
        byd__private__get_num_core_available(num_core)
        set(command make install -j${num_core})
    elseif(WIN32 AND MSVC)
        set(command nmake install)
    endif()


    byd__script__begin("${script_dir}/install.cmake")
        byd__script__add_run_command_or_abort_function()
        __byd__Qt5__script__add_env_var()
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__Qt5__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)



    if(UNIX)
        set(command make test)
    elseif(WIN32 AND MSVC)
        set(command nmake test)
    endif()



    byd__script__begin("${script_dir}/test.cmake")
        byd__script__add_run_command_or_abort_function()
        __byd__Qt5__script__add_env_var()
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_test_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
