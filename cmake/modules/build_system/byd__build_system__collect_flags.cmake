

function(byd__build_system__collect_cross_compile_flags lang compile_flags include_flags link_flags)

    if(NOT CMAKE_CROSSCOMPILING)
        return()
    endif()

    if(ANDROID)
        if(BOOST_TOOLSET STREQUAL "clang")
            if(CMAKE_${lang}_COMPILER_TARGET)
                byd__func__accum(__compile_flags "--target=${CMAKE_${lang}_COMPILER_TARGET}")
            endif()
            if(CMAKE_${lang}_COMPILER_EXTERNAL_TOOLCHAIN)
                byd__func__accum(__compile_flags "--gcc-toolchain=${CMAKE_${lang}_COMPILER_EXTERNAL_TOOLCHAIN}")
            endif()
        endif()
        if(CMAKE_SYSROOT)
            byd__func__accum(__compile_flags "--sysroot=${CMAKE_SYSROOT}")
        endif()

        if(CMAKE_${lang}_STANDARD_INCLUDE_DIRECTORIES)
            foreach(include_dir ${CMAKE_${lang}_STANDARD_INCLUDE_DIRECTORIES})
                byd__func__accum(__include_flags "-isystem ${include_dir}")
            endforeach()
        endif()

        if(CMAKE_${lang}_STANDARD_LIBRARIES)
            foreach(library ${CMAKE_${lang}_STANDARD_LIBRARIES})
                # begin workaround : CMAKE_${lang}_STANDARD_LIBRARIES could contain space and " at the begining and the end
                string(STRIP ${library} library)
                string(REGEX REPLACE "\"" "" library ${library})
                # end workaround
                byd__func__accum(__link_flags "-l${library}")
            endforeach()
        endif()
    endif()

    set(${compile_flags} "${__compile_flags}" PARENT_SCOPE)
    set(${include_flags} "${__include_flags}" PARENT_SCOPE)
    set(${link_flags} "${__link_flags}" PARENT_SCOPE)

endfunction()



function(byd__build_system__collect_flags lang compile_flags include_flags link_flags)

    set(__compile_flags "")
    set(__include_flags "")
    set(__link_flags    "")

    if(CMAKE_BUILD_TYPE)
        string(TOUPPER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE__UPPER_CASE)
    endif()

    byd__build_system__collect_cross_compile_flags(${lang} cc_compile_flags cc_include_flags cc_link_flags)
    byd__func__accum_if_def(__compile_flags cc_compile_flags)
    byd__func__accum_if_def(__include_flags cc_include_flags)
    byd__func__accum_if_def(__link_flags cc_link_flags)


    byd__func__accum_if_def(__compile_flags CMAKE_${lang}_FLAGS)
    byd__func__accum_if_def(__compile_flags CMAKE_${lang}_FLAGS_${CMAKE_BUILD_TYPE__UPPER_CASE})
    byd__func__accum_if_def(__link_flags CMAKE_EXE_LINKER_FLAGS)
    byd__func__accum_if_def(__link_flags CMAKE_EXE_LINKER_FLAGS_${CMAKE_BUILD_TYPE__UPPER_CASE})


    if(CMAKE_INSTALL_PREFIX)
        set(prefix_dir  "${CMAKE_INSTALL_PREFIX}")
        set(include_dir "${prefix_dir}/include")
        set(lib_dir     "${prefix_dir}/lib")

        byd__func__accum(__include_flags "-I${include_dir}")
        byd__func__accum(__link_flags    "-L${lib_dir}")
    endif()


    set(${compile_flags} "${__compile_flags}" PARENT_SCOPE)
    set(${include_flags} "${__include_flags}" PARENT_SCOPE)
    set(${link_flags}    "${__link_flags}" PARENT_SCOPE)

endfunction()
