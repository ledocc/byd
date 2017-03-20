
byd__Qt5__configure__add_args(${package} "-I${CMAKE_INSTALL_PREFIX}/include")
byd__Qt5__configure__add_args(${package} "-L${CMAKE_INSTALL_PREFIX}/lib")
byd__Qt5__configure__add_args(${package} -rpath)
byd__Qt5__configure__add_args(${package} -continue)

if(CMAKE_VERBOSE_MAKEFILE)
    byd__Qt5__configure__add_args(${package} -verbose)
else()
    byd__Qt5__configure__add_args(${package} -silent)
endif()
