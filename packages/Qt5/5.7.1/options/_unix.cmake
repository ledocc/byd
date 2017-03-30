
if(CMAKE_INSTALL_PREFIX)
    byd__Qt5__configure__add_args(${package} "-I" "${CMAKE_INSTALL_PREFIX}/include")
    byd__Qt5__configure__add_args(${package} "-L" "${CMAKE_INSTALL_PREFIX}/lib")
endif()
byd__Qt5__configure__add_args(${package} -rpath)
byd__Qt5__configure__add_args(${package} -continue)
