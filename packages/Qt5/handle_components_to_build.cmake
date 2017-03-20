include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



byd__package__get_components_to_build(${package} components_to_build)
if(components_to_build)

    include("${VERSION_DIR}/components.cmake")

    foreach(component IN LISTS QT5_COMPONENTS)
        set(QT5_BUILD_${component} OFF)
    endforeach()

    foreach(component IN LISTS components_to_build)
        set(QT5_BUILD_${component} ON)
    endforeach()

    foreach(component IN LISTS QT5_COMPONENTS)
        if(NOT QT5_BUILD_${component})
            byd__Qt5__configure__add_args(${package} -skip ${component})
        endif()
    endforeach()

endif()
