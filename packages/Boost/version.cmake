include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(
    ${package} 1.63.0
    URL "https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.bz2"
    URL_MD5 1c837ecd990bb022d07e7aab32b09847
    )

byd__package__add_version(
    ${package} 1.64.0
    URL "https://sourceforge.net/projects/boost/files/boost/1.64.0/boost_1_64_0.tar.bz2"
    HASH SHA1=51421ef259a4530edea0fbfc448460fcc5c64edb
    )
