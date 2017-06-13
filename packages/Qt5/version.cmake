include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__package__add_version(
    ${package} 5.5.1
    URL "https://download.qt.io/archive/qt/5.5/5.5.1/single/qt-everywhere-opensource-src-5.5.1.tar.xz"
    URL_HASH SHA1=5933651d46691ff6e919a49f5a380b9a217d30fb
    )

byd__package__add_version(
    ${package} 5.7.1
    URL "https://download.qt.io/archive/qt/5.7/5.7.1/single/qt-everywhere-opensource-src-5.7.1.tar.xz"
    URL_HASH SHA1=bedd61b2767239bad01fa9ce3d1e2e63ecf721bd
    )

byd__package__add_version(
    ${package} 5.8.0
    URL "https://download.qt.io/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.tar.xz"
    URL_HASH SHA1=1a056ca4f731798e4142a691d0448c2c853228ca
    )

byd__package__add_version(
    ${package} 5.9.0
    URL "https://download.qt.io/archive/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz"
    URL_HASH SHA1=6308cd1e95c64323490a9a526a7f0a380cdcfb6e
    )
