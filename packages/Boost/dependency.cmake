include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__set_component_dependencies(${package}
    COMPONENT
        iostreams
    DEPENDS
        zlib
        bzip2
)

if(NOT ANDROID)
    byd__package__set_component_dependencies(${package}
        COMPONENT
            regex
        DEPENDS
            icu
    )

    byd__package__set_component_dependencies(${package}
        COMPONENT
            locale
        DEPENDS
            icu
    )
endif()
