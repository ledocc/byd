include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(
    ${package} 2.5.4
    URL "http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.5.4.tar.gz"
    URL_HASH SHA1=1fa2eb0b1c8285a4f51132ac78cd8c95f302b768
)

byd__package__add_version(
    ${package} 2.5.5
    URL "http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.5.5.tar.gz"
    URL_HASH SHA1=36511c98fe450bbb50da8c8a3d4eba2cc7d0f83c
)
