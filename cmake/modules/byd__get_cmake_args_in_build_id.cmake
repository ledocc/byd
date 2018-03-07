
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__archive__add_cmake_args_build_id args variable )

    if(NOT DEFINED ${variable})
        return()
    endif()

    list(APPEND ${args} ${variable})
    set(${args} "${${args}}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_cmake_args_in_build_id result)

    set(CMAKE_ARGS
        BUILD_SHARED_LIBS
        CMAKE_BUILD_TYPE
        CMAKE_C_COMPILER_ID
        CMAKE_C_COMPILER_VERSION
        CMAKE_C_FLAGS
        CMAKE_CXX_COMPILER_ID
        CMAKE_CXX_COMPILER_VERSION
        CMAKE_CXX_EXTENSIONS
        CMAKE_CXX_FLAGS
        CMAKE_CXX_STANDARD
        CMAKE_CXX_STANDARD_REQUIRED
        CMAKE_EXE_LINKER_FLAGS
        CMAKE_INTERPROCEDURAL_OPTIMIZATION
        CMAKE_MODULE_LINKER_FLAGS
        BYD_OSX_SDK
        CMAKE_POSITION_INDEPENDENT_CODE
        CMAKE_SHARED_LINKER_FLAGS
        CMAKE_STATIC_LINKER_FLAGS
        )

    if (NOT CMAKE_BUILD_TYPE STREQUAL "")
        string(TOUPPER ${CMAKE_BUILD_TYPE} buildType)
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_C_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_CXX_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_EXE_LINKER_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_MODULE_LINKER_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_SHARED_LINKER_FLAGS_${buildType})
        __byd__archive__add_cmake_args_build_id(CMAKE_ARGS CMAKE_STATIC_LINKER_FLAGS_${buildType})
    endif()

    set(${result} "${CMAKE_ARGS}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
