include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__set_dependency(${package}
    xcb
    X11
    Xau
    Xdmcp
    Xext
    )
