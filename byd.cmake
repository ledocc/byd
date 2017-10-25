
if(NOT DEFINED CMUT_ROOT)

    set(CMUT_ROOT "$ENV{CMUT_ROOT}")
    if(NOT CMUT_ROOT)
        message(STATUS "byd require cmut.")
        message(STATUS "CMUT_ROOT variable and environment variable is not defined.")
        message(FATAL_ERROR "define CMUT_ROOT to use byd.")
    endif()
endif()

include(${CMUT_ROOT}/cmut.cmake)
cmut_info("[byd] - cmut location : \"${CMUT_ROOT}\".")
cmut_info("[byd] - cmut version  : \"${CMUT_VERSION}\".")

if(CMUT_VERSION VERSION_LESS 0.5.0)
    message(FATAL_ERROR "byd require cmut version 0.5.0 or greater.")
endif()

set(BYD_ROOT "${CMAKE_CURRENT_LIST_DIR}")
include("${BYD_ROOT}/cmake/modules.cmake")
cmut_info("[byd] - byd location  : \"${BYD_ROOT}\".")
cmut_info("[byd] - byd version   : \"${BYD_VERSION}\".")
