include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)
    set(${package}_PLATFORM "Linux")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Darwin)
    set(${package}_PLATFORM "MacOSX")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Windows)
    set(${package}_PLATFORM "MSYS/MSVC")
else()
    cmut_fatal("You try to build ${package} on platform not handle by this script. fix it and try again.")
    return()
endif()




if (MSVC)
    if (MSVC60)
	set(ICU_TOOLSET "v60")
    elseif(MSVC70)
	set(ICU_TOOLSET "v70")
    elseif(MSVC71)
	set(ICU_TOOLSET "v71")
    elseif(MSVC80)
	set(ICU_TOOLSET "v80")
    elseif(MSVC90)
	set(ICU_TOOLSET "v90")
    elseif(MSVC10)
	set(ICU_TOOLSET "v100")
    elseif(MSVC11)
	set(ICU_TOOLSET "v110")
    elseif(MSVC12)
	set(ICU_TOOLSET "v120")
    elseif(MSVC13)
	set(ICU_TOOLSET "v130")
    elseif(MSVC14)
	set(ICU_TOOLSET "v140")
    else()
	cmut_fatal("You try to build ${package} on platform not ahndle by this script. fix it and try again.")
	return()
    endif()
endif()


#byd__autotool__configure__add_args(${package} ${${package}_PLATFORM})

byd__autotool__configure__add_args(${package} --enable-tests)
byd__autotool__configure__add_args(${package} --disable-samples)

byd__autotool__configure__add_args(${package} --enable-rpath)




if(MSVC)
    set(ICU_SLN source/allinone/allinone.sln)
    set(WINDOWS_INSTALL_SCRIPT install_on_windows.cmake)

    set(UPDATE_CMD devenv /Upgrade ${ICU_SLN})
    set(CMUT_EP_${package}_CONFIGURE_CMD echo no configuration on windows)
    set(CMUT_EP_${package}_BUILD_CMD     MSbuild /m:${CMUT_NUM_CORE_AVAILABLE} /p:Configuration=${CMAKE_BUILD_TYPE} /p:PlatformToolset=${ICU_TOOLSET} ${ICU_SLN})
    set(CMUT_EP_${package}_INSTALL_CMD   ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -P "..\\${WINDOWS_INSTALL_SCRIPT}")


else()
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
