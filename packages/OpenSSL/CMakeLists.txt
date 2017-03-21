include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/byd__openssl__generate.cmake")


byd__EP__compile_in_source(${package} 1)

byd__openssl__generate_configure_command(${package})
byd__openssl__generate_build_command(${package})
byd__openssl__generate_install_command(${package})
byd__is_disable_test_step(disable_test)
if(NOT disable_test)
    byd__openssl__generate_test_command(${package})
endif()
byd__EP__add(${package})


if(APPLE)
    byd__fixup_dylib(${package})
endif()
