include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

byd__autotool__configure__add_args(${package} "--without-iconv" "--with-icu")
byd__autotool__configure__add_args(${package} "--without-python")


byd__autotool__add(${package})
