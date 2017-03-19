

byd__package__set_component_dependencies(Boost
    COMPONENT
        iostreams
    DEPENDS
        zlib
        bzip2
    )

byd__package__set_component_dependencies(Boost
    COMPONENT
        regex
    DEPENDS
        icu
    )

byd__package__set_component_dependencies(Boost
    COMPONENT
        locale
    DEPENDS
        icu
    )
