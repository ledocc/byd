

function(__byd__variable__compiler_compatible_id__get_id result lang)

    if("${CMAKE_${lang}_COMPILER_ID}" STREQUAL "AppleClang")
        set(id "Clang-libc++")
    elseif("${CMAKE_${lang}_COMPILER_ID}" STREQUAL "MSVC")
        set(id ${CMAKE_${lang}_COMPILER_ID}__${CMAKE_${lang}_COMPILER_VERSION})
    elseif("${CMAKE_${lang}_COMPILER_ID}" STREQUAL "Clang")
        if("-stdlib=libc++" IN_LIST CMAKE_CXX_FLAGS)
            set(id "Clang-libc++")
        else()
            set(id "GNU")
        endif()
    elseif("${CMAKE_${lang}_COMPILER_ID}" STREQUAL "GNU")
        set(id "GNU")
    else()
        cmut_warn("[cmut][variable][compiler_compatible_id] : compiler \"${CMAKE_${lang}_COMPILER_ID}\" no handle by bydist.\nDefine BYD__${lang}_COMPILER_COMPATIBLE_ID = ${CMAKE_${lang}_COMPILER_ID}.")
        set(id ${CMAKE_${lang}_COMPILER_ID})
    endif()

    byd__func__return(id)

endfunction()

function(byd__variable__compiler_compatible_id__define)

    __byd__variable__compiler_compatible_id__get_id(id C)
    set(BYD__C_COMPILER_COMPATIBLE_ID "${id}" CACHE STRING "C compiler compatible id.")

    __byd__variable__compiler_compatible_id__get_id(id CXX)
    set(BYD__CXX_COMPILER_COMPATIBLE_ID "${id}" CACHE STRING "C++ compiler compatible id.")

endfunction()
