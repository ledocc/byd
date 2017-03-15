


include("${BYD_ROOT}/cmake/modules/private/byd__private__error_if_property_is_defined.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})



    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(openssl_build_type "debug-")
    endif()

    if(WIN32)
        if(MSVC)
            set(openssl_platform "VC-WIN32")
            set(openssl_compiler "")
        endif()
    elseif(APPLE)
        set(openssl_platform "darwin64")
        set(openssl_compiler "-cc")
    elseif(UNIX)
        set(openssl_architecture "-x86_64")
        set(openssl_platform "linux")
        if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
            set(openssl_compiler "")
        elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
            set(openssl_compiler "-clang")
        endif()
    endif()


    if(NOT DEFINED openssl_compiler)
        cmut_fatal("compiler \"${CMAKE_C_COMPILER_ID}\" not supported by OpenSSL byd script")
        return()
    endif()
    if(NOT DEFINED openssl_platform)
        cmut_fatal("platform not supported by OpenSSL byd script")
        return()
    endif()


    set(configure_args "")
    list(APPEND configure_args "${openssl_build_type}${openssl_platform}${openssl_architecture}${openssl_compiler}")

    if(CMAKE_INSTALL_PREFIX)
        list(APPEND configure_args "--prefix=${CMAKE_INSTALL_PREFIX}")
    endif()

    if(BUILD_SHARED_LIBS)
        list(APPEND configure_args "shared")
    else()
        list(APPEND configure_args "no-shared")
    endif()

    if(BYD__zlib)
        if(BUILD_SHARED_LIBS)
            list(APPEND configure_args "zlib-dynamic")
        else()
            list(APPEND configure_args "zlib")
        endif()
        if(CMAKE_INSTALL_PREFIX)
            list(APPEND configure_args "--with-zlib-include=${CMAKE_INSTALL_PREFIX}/include")
            list(APPEND configure_args "--with-zlib-lib=${CMAKE_INSTALL_PREFIX}/lib")
        endif()
    else()
        list(APPEND configure_args "no-zlib")
    endif()


    if(WIN32 AND MSVC)
        list(APPEND configure_args "no-asm")
    endif()



    set(command "perl" "Configure" "${configure_args}")



    byd__script__begin("${CMAKE_BINARY_DIR}/${package}/src/${package}-script/configure.cmake")
        byd__script__add_run_command_or_abort_function()

        byd__script__command("${command}")
        if(WIN32 AND MSVC)
            byd__script__command("ms\\do_ms")
        endif()
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "../${package}-script/configure.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})


    if(UNIX)
        set(command make -j${BYD__BUILD__NUM_CORE_AVAILABLE})
    elseif(WIN32 AND MSVC)
        set(command nmake -f "ms\\ntdll.mak")
    endif()

    byd__script__begin("${CMAKE_BINARY_DIR}/${package}/src/${package}-script/build.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "../${package}-script/build.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})


    if(UNIX)
        set(command make install_sw -j${BYD__BUILD__NUM_CORE_AVAILABLE})
    elseif(WIN32 AND MSVC)
        set(command nmake -f "ms\\ntdll.mak" install_sw)
    endif()


    byd__script__begin("${CMAKE_BINARY_DIR}/${package}/src/${package}-script/install.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "../${package}-script/install.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})


    if(UNIX)
        # disable -j option ==>> fail the test
        set(command make test)
    elseif(WIN32 AND MSVC)
        set(command nmake -f "ms\\ntdll.mak" test)
    endif()



    byd__script__begin("${CMAKE_BINARY_DIR}/${package}/src/${package}-script/test.cmake")
        byd__script__add_run_command_or_abort_function()
        byd__script__command("${command}")
    byd__script__end()


    byd__set_property(${__property_name} "${CMAKE_COMMAND}" -P "../${package}-script/test.cmake")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
