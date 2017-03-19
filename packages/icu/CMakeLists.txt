include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/determine_platform.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/determine_toolset.cmake")









if(MSVC)
    set(ICU_SLN source/allinone/allinone.sln)
    set(WINDOWS_INSTALL_SCRIPT install_on_windows.cmake)

    set(UPDATE_CMD devenv /Upgrade ${ICU_SLN})
    set(CMUT_EP_${package}_CONFIGURE_CMD echo no configuration on windows)
    set(CMUT_EP_${package}_BUILD_CMD     MSbuild /m:${CMUT_NUM_CORE_AVAILABLE} /p:Configuration=${CMAKE_BUILD_TYPE} /p:PlatformToolset=${ICU_TOOLSET} ${ICU_SLN})
    set(CMUT_EP_${package}_INSTALL_CMD   ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -P "..\\${WINDOWS_INSTALL_SCRIPT}")


else()
    byd__package__get_components(${package} components)
    byd__package__get_components_to_build(${package} components_to_build)
    foreach(component IN LISTS components)
        if(component IN LIST components_to_build)
            set(action enable)
        else()
            set(action disable)
        endif()
        byd__autotool__configure__add_args(${package} --${action}-${component})
    endforeach()

    byd__autotool__configure__add_args(${package} --enable-tests)
    byd__autotool__configure__add_args(${package} --disable-samples)
    byd__autotool__configure__add_args(${package} --enable-rpath)

    byd__autotool__configure__set_configure_cmd(${package} "source/runConfigureICU" ${${package}_PLATFORM})
    byd__autotool__add(${package} TEST_TARGET check)
endif()


ExternalProject_Get_Property(${package} SOURCE_DIR)

if(APPLE)
    include(${PROJECT_SOURCE_DIR}/cmake/fixup_dylib.cmake)
    fixup_dylib(${package} "${SOURCE_DIR}")
endif()

if(WIN32)
    file(
        COPY ${WINDOWS_INSTALL_SCRIPT}
        DESTINATION ${SOURCE_DIR}/..
        )
endif()
