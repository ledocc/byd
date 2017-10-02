include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__set_dependency(${package}
#    doubleconvertion
#    freetype
#    harfbuzz
    icu
#    libjpeg_turbo
#    libpng
#    libproxy
    OpenSSL
#    pcre
    zlib
    )

if(UNIX AND NOT APPLE)
    byd__package__add_dependency(${package}
#        alsa
#        expat
#        fontconfig
#        glib
#        gtk
#        ICE
#        libinput
#        libxslt
        libwebp
#        mesa
#        mtdev
#        journald
#        pulseaudio
#        syslog
#        SM
#        xcb
#        xcb-util-cursor
#        xcb-util-errors
#        xcb-util-keysyms
#        xcb-util-image
#        xcb-util-renderutil
#        xcb-util-wm
#        xkbcommon
#        xkbcommon-evdev
#        xshmfence
#        X11
#        Xcomposite
#        Xcursor
#        Xdamage
#        Xext
#        Xfixes
#        Xi
#        Xrandr
#        Xrender
#        Xtst
#        Xxf86vm
#        XScrnSaver
        )
endif()

# dependency package
#g++ libcups2-dev libasound-dev libfontconfig-dev libglib2.0-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libicu-dev libsystemd-journal-dev libinput-dev libmtdev-dev libproxy-dev libssl-dev libegl1-mesa-dev libgl1-mesa-dev libopenvg1-mesa-dev pkg-config libpulse-dev libudev-dev libxcb-xkb-dev libicu-dev libsystemd-journal-dev libinput-dev libmtdev-dev libproxy-dev libssl-dev libegl1-mesa-dev libgl1-mesa-dev libopenvg1-mesa-dev pkg-config libpulse-dev libudev-dev libxcb-xkb-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev libxkbcommon-dev libxml2-dev libxslt1-dev libmysqlclient-dev unixodbc-dev libpq-dev libxrender-dev libwebp-dev libxcb-render-util0-dev libgles2-mesa-dev libcap-dev libxtst-dev libnss3-dev gperf re2c bison flex libpci-dev libdbus1-dev libxcb-xinerama0-dev libdbus-1-dev libxcomposite-dev libxcursor-dev libxrandr-dev libxss-dev
