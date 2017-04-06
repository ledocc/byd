include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


byd__package__add_version(
    ${package} 1.4.2
    URL "https://sourceforge.net/projects/libjpeg-turbo/files/1.4.2/libjpeg-turbo-1.4.2.tar.gz"
    URL_HASH SHA1=2666158ccd5318513f875867bbc4af52f6eb9f0b
    )

byd__package__add_version(
    ${package} 1.5.1
    URL "https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-1.5.1.tar.gz"
    URL_HASH SHA1=ebb3f9e94044c77831a3e8c809c7ea7506944622
    )

byd__package__add_version(
    ${package} 1.6-dev
    GIT_REPOSITORY https://github.com/libjpeg-turbo/libjpeg-turbo.git
    GIT_TAG dev
    )
