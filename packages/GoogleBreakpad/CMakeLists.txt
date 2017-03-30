include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")


# GoogleBreakpad support only static library
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


    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_script_dir(${package} source_dir)

    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__env__set(GYP_MSVS_VERSION ${MSVC_YEARS})
        byd__script__command("${source_dir}/src/tools/gyp/gyp.bat" --no-circular-check)
        byd__script__command("${source_dir}/src/client/windows/breakpad_client.gyp")
        byd__script__command("${source_dir}/src/tools/windows/dump_syms/dump_syms.gyp")
    byd__script__end()
    byd__build_system__default_configure_command(${package})

    byd__script__begin("${script_dir}/build.cmake")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/client/windows/common.vcxproj")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/client/windows/crash_generation/crash_generation_client.vcxproj")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/client/windows/crash_generation/crash_generation_server.vcxproj")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/client/windows/handler/exception_handler.vcxproj")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/client/windows/sender/crash_report_sender.vcxproj")
        byd__script__command(msbuild /p:Configuration=${CMAKE_BUILD_TYPE} "${source_dir}/src/tools/windows/dump_syms/dump_syms.vcxproj")
    byd__script__end()
    byd__build_system__default_build_command(${package})

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__command(python "${source_dir}/scripts/windows/install_google_breakpad.py" "${source_dir}" "${CMAKE_INSTALL_PREFIX}")
    byd__script__end()
    byd__build_system__default_install_command(${package})


elseif(CMAKE_HOST_UNIX)

    byd__autotool__add(${package} SKIP test)

endif()
