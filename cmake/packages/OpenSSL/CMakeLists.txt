set(package OpenSSL)


byd__package__add_version(${package} 1.0.2k
    URL "https://gitlab.unowhy.com/unowhy-sqool/openssl/repository/archive.tar.bz2?ref=OpenSSL_1_0_2k"
    URL_HASH MD5=9ab0c549d179ec7d578b7de18823cc0d
    )


include("${CMAKE_CURRENT_LIST_DIR}/byd__openssl__generate.cmake")

byd__openssl__generate_configure_command(${package})
byd__openssl__generate_build_command(${package})
byd__openssl__generate_install_command(${package})
byd__openssl__generate_test_command(${package})


byd__EP__compile_in_source(${package} 1)

byd__EP__add(${package})


if(APPLE)
    include(${PROJECT_SOURCE_DIR}/cmake/fixup_dylib.cmake)
    fixup_dylib(${package})
endif()
