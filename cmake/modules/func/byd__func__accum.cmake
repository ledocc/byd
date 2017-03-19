

function(byd__func__accum result value)
    if("x${${result}}" STREQUAL "x")
        byd__func__return_value("${value}")
    else()
        byd__func__return_value("${${result}} ${value}")
    endif()
endfunction()

function(byd__func__accum_if_def result variable)
    if(${variable})
        byd__func__accum(${result} "${${variable}}")
        byd__func__return_value("${${result}}")
    endif()
endfunction()
