set(package zlib)


byd__package__set_id(
    ${package}
    URL "http://zlib.net/"
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    )


byd__package__add_version(
    ${package} 1.2.11-unowhy
    GIT_REPOSITORY "https://github.com/ledocc/zlib.git"
    GIT_TAG "1.2.11-unowhy"
    )


byd__cmake__add(${package})
