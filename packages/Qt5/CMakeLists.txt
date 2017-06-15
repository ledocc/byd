include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/byd__Qt5__generate.cmake")


byd__package__get_version_to_build(${package} version_to_build)
set(VERSION_DIR "${CMAKE_CURRENT_LIST_DIR}/${version_to_build}")


byd__Qt5__configure__use_open_source(${package})
include("${CMAKE_CURRENT_LIST_DIR}/handle_components_to_build.cmake")

include("${VERSION_DIR}/options/dependencies.cmake")
include("${VERSION_DIR}/options/all_platform.cmake")
if(APPLE)
    include("${VERSION_DIR}/options/apple.cmake")
elseif(MSVC)
    include("${VERSION_DIR}/options/msvc.cmake")
elseif(UNIX)
    include("${VERSION_DIR}/options/linux.cmake")
endif()



byd__Qt5__generate_configure_command(${package})
byd__Qt5__generate_build_command(${package})
byd__Qt5__generate_install_command(${package})

file(GLOB patchList
    LIST_DIRECTORIES false
    "${VERSION_DIR}/patch/*.patch"
    )
byd__custom_patch(${package} patchList)



byd__EP__add(${package})




ExternalProject_Add_Step(
    ${package}
    install_qt_conf
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_LIST_DIR}/qt.conf" "${CMAKE_INSTALL_PREFIX}/bin/qt.conf"
    DEPENDEES install
    ALWAYS 1
    )
