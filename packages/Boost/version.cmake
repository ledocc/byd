include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(
    ${package} 1.63.0
    URL "https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.bz2"
    URL_MD5 1c837ecd990bb022d07e7aab32b09847
    )

byd__package__add_version(
    ${package} 1.64.0
    URL "https://sourceforge.net/projects/boost/files/boost/1.64.0/boost_1_64_0.tar.bz2"
    URL_HASH SHA1=51421ef259a4530edea0fbfc448460fcc5c64edb
    )

byd__package__add_version(
    ${package} 1.65.1
    URL "https://sourceforge.net/projects/boost/files/boost/1.65.1/boost_1_65_1.tar.bz2"
    URL_HASH SHA1=4a5b0c3c1b1b9a4d6cb6a6cc395e903e76f76720
    )
