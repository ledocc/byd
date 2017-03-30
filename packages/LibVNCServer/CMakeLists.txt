include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


macro(LibVNCServer_add_config_arg package_name cmake_option)
    byd__package__is_build(${package_name} package_is_build)
    byd__cmake__configure__add_arg(${package} ${cmake_option} ${package_is_build})
endmacro()




byd__package__get_components_to_build(${package} components)
if(components)
    foreach(component vncserver vncclient)
        set(LIBVNCSERVER_BUILD_${component} OFF)
    endforeach()
    foreach(component IN LISTS components)
        set(LIBVNCSERVER_BUILD_${component} ON)
    endforeach()
    foreach(component vncserver vncclient)
        byd__cmake__configure__add_arg(${package} LIBVNCSERVER_BUILD_${component} ${LIBVNCSERVER_BUILD_${component}})
    endforeach()
endif()


LibVNCServer_add_config_arg(libjpeg_turbo LIBVNCSERVER_use_jpeg_compression)
LibVNCServer_add_config_arg(libpng        LIBVNCSERVER_use_png_compression)
LibVNCServer_add_config_arg(zlib          LIBVNCSERVER_use_zlib_compression)
LibVNCServer_add_config_arg(OpenSSL       LIBVNCSERVER_use_openssl)


byd__cmake__add(${package} SKIP test)
