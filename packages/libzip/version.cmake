include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(
    ${package} 1.2.0
    URL "https://github.com/ledocc/libzip/archive/rel-1-2-0.tar.gz"
    URL_HASH SHA1=ea219e6d2c82d604a8513a66250e4a4c2049b7d1
)

byd__package__add_version(
    ${package} 1.2.0-unowhy-p1
    URL "https://github.com/ledocc/libzip/archive/rel-1.2.0-unowhy-p1.tar.gz"
    URL_HASH SHA1=94d29ddd4540de7a85a20a1b068a98bb88ae0a2e
)

byd__package__add_version(
    ${package} 1.2.0-unowhy-p2
    URL "https://github.com/ledocc/libzip/archive/rel-1.2.0-unowhy-p2.tar.gz"
    URL_HASH SHA1=49e330f0808f015f412a2b06dc5237f8d1b6bb94
)
