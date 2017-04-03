include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")




if (UNIX)
    byd__autotool__configure__add_args(${package} "--enable-pcre16")
    byd__autotool__configure__add_args(${package} "--enable-pcre32")
    byd__autotool__configure__add_args(${package} "--enable-jit")
    byd__autotool__configure__add_args(${package} "--enable-utf")
    byd__autotool__configure__add_args(${package} "--enable-unicode-properties")
    #byd__autotool__configure__add_args(${package} "--enable-newline-is-any")

    byd__autotool__add(${package})
else()

    byd__cmake__configure__add_arg(${package} PCRE_BUILD_PCRE32 ON)
    byd__cmake__configure__add_arg(${package} PCRE_BUILD_PCRE16 ON)
    byd__cmake__configure__add_arg(${package} PCRE_SUPPORT_UNICODE_PROPERTIE ON)
    byd__cmake__configure__add_arg(${package} PCRE_SUPPORT_UTF ON)
    byd__cmake__add(${package})

endif()