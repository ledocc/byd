set(package zlib)


byd__package__set_id(
    ${package}
    URL "http://zlib.net/"
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    )


byd__package__add_version(
    ${package} 1.2.11-unowhy
    URL https://github.com/ledocc/zlib/archive/1.2.11-unowhy.tar.gz
    URL_HASH SHA1=dc613f50140492f61fecea1ba5539b0e49abdd48
)


byd__cmake__add(${package})
