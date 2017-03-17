include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



set(BUILD_SHARED_LIBS OFF)

if(WIN32)
    if (MSVC)
	if(MSVC12)
	  set(MSVC_YEARS "2013")
	elseif(MSVC14)
	  set(MSVC_YEARS "2015")
	else()
	    message(SEND_ERROR "you try to build ${module} on platform not handle by this script. fix it and try again.")
	    return()
	endif()
    endif()


    set(CMUT_EP_${module}_CONFIGURE_CMD
        COMMAND set GYP_MSVS_VERSION=${MSVC_YEARS}
        COMMAND
        src/tools/gyp/gyp.bat --no-circular-check
        src/client/windows/breakpad_client.gyp
        src/tools/windows/dump_syms/dump_syms.gyp
        )
    set(CMUT_EP_${module}_BUILD_CMD
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/client/windows/common.vcxproj &&
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/client/windows/crash_generation/crash_generation_client.vcxproj &&
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/client/windows/crash_generation/crash_generation_server.vcxproj &&
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/client/windows/handler/exception_handler.vcxproj &&
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/client/windows/sender/crash_report_sender.vcxproj &&
        msbuild /p:Configuration=${CMAKE_BUILD_TYPE} src/tools/windows/dump_syms/dump_syms.vcxproj
        )
    set(CMUT_EP_${module}_INSTALL_CMD python scripts/windows/install_google_breakpad.py . ${CMAKE_INSTALL_PREFIX})

elseif(CMAKE_HOST_UNIX)

    byd__autotool__add(${package} SKIP test)

endif()
