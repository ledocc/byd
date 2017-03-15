
if(NOT DEFINED CMUT_ROOT)

    set(CMUT_ROOT "$ENV{CMUT_ROOT}")
    if(NOT CMUT_ROOT)
        message(STATUS "byd require cmut.")
        message(STATUS "CMUT_ROOT variable and environment variable is not defined.")
        message(FATAL_ERROR "define CMUT_ROOT to use byd.")
    endif()

endif()

include("${BYD_ROOT}/cmake/modules.cmake")
