

macro(byd__func__return variable)
    set(${result} "${${variable}}" PARENT_SCOPE)
endmacro()

macro(byd__func__return_value value)
    set(${result} "${value}" PARENT_SCOPE)
endmacro()
