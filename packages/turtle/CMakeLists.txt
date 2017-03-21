include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")




set(install_command
    ${CMAKE_COMMAND} -E copy_directory
        "include/turtle"
        "${CMAKE_INSTALL_PREFIX}/include/turtle"
        )

byd__EP__set_empty_command(${package})
byd__EP__set_package_argument(${package} INSTALL INSTALL_COMMAND "${install_command}")
byd__EP__compile_in_source(${package} 1)
byd__EP__add(${package})
