
byd__Qt5__configure__add_arg_if_dependency_is_added(${package} zlib)
byd__Qt5__configure__add_arg_if_dependency_is_added(${package} libpng)

byd__package__is_added(libjpeg_turbo is_added)
if(is_added)
    byd__Qt5__configure__add_args(${package} -system-libjpeg)
else()
    byd__Qt5__configure__add_args(${package} -qt-libjpeg)
endif()

byd__Qt5__configure__add_args(${package} -qt-doubleconversion)
byd__Qt5__configure__add_arg_if_dependency_is_added(${package} freetype)
byd__Qt5__configure__add_arg_if_dependency_is_added(${package} harfbuzz)

byd__package__is_added(OpenSSL is_added)
if(is_added)
    byd__Qt5__configure__add_args(${package} -openssl)
endif()

byd__Qt5__configure__add_arg_if_dependency_is_added(${package} libproxy)
byd__Qt5__configure__add_arg_if_dependency_is_added(${package} pcre)
