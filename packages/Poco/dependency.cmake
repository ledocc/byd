
byd__package__set_dependency(Poco
    zlib
    OpenSSL
    )


byd__package__set_component_dependencies(Poco
    COMPONENT
        Crypto
    DEPENDS
        OpenSSL
    )
byd__package__set_component_dependencies(Poco
    COMPONENT
        NetSSL
    DEPENDS
        OpenSSL
    )

byd__package__set_component_dependencies(Poco
    COMPONENT
        PDF
    DEPENDS
        zlib
    )

byd__package__set_component_dependencies(Poco
    COMPONENT
        XML
    DEPENDS
        libexpat
    )
