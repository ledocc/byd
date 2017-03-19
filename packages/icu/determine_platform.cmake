include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)
    set(${package}_PLATFORM "Linux")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Darwin)
    set(${package}_PLATFORM "MacOSX")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Windows)
    set(${package}_PLATFORM "MSYS/MSVC")
else()
    cmut_fatal("You try to build ${package} on platform not handle by this script. fix it and try again.")
    return()
endif()
