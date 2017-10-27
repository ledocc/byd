include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")




set(install_command
    COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_INSTALL_PREFIX}/include/ThreadPool"
    COMMAND ${CMAKE_COMMAND} -E copy "ThreadPool.h" "${CMAKE_INSTALL_PREFIX}/include/ThreadPool/ThreadPool.h"
    )

byd__EP__set_empty_command(${package})
byd__EP__set_package_argument(${package} INSTALL INSTALL_COMMAND "${install_command}")
byd__EP__compile_in_source(${package} 1)
byd__EP__add(${package})
