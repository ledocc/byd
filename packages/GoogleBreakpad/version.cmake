include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__add_version(
    ${package} 42.0-unowhy
    GIT_REPOSITORY http://github.com/ledocc/breakpad.git
    GIT_TAG unowhy
)
