include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



if(BUILD_SHARED_LIBS)
    byd__cmake__add_cmake_arg(${package} POCO_STATIC OFF)
else()
    byd__cmake__add_cmake_arg(${package} POCO_STATIC ON)
endif()

byd__cmake__add_cmake_arg(${package} HUNTER_ENABLED OFF)


byd__package__get_components_to_build(${package} components_to_build)
if(components_to_build)

    include("${CMAKE_CURRENT_LIST_DIR}/component.cmake")
    byd__package__get_components(${package} components)

    foreach(component ${components})

        string(TOUPPER ${component} COMPONENT)

        if(component IN_LIST components_to_build)
            set(enable ON)
        else()
            set(enable OFF)
        endif()

        byd__cmake__add_cmake_arg(${package} "ENABLE_${COMPONENT}" "${enable}")

    endforeach()
endif()


if(APPLE)
    byd__fixup_dylib(${package})
endif()
byd__cmake__add(${package} SKIP test)
