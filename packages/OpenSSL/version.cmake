include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(${package} 1.0.2k
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_0_2k.tar.gz"
    URL_HASH SHA1=462944eff7b045d950deaaa86798190cbdc5278a
    )

byd__package__add_version(${package} 1.0.2l
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz"
    URL_HASH SHA1=5bea0957b371627e8ebbee5bef221519e94d547c
    )
