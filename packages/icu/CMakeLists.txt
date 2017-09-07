include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/determine_platform.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/determine_toolset.cmake")









if(MSVC)
    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)
    byd__private__get_num_core_available(num_jobs)

    set(ICU_SLN ${source_dir}/source/allinone/allinone.sln)
    set(WINDOWS_INSTALL_SCRIPT install_on_windows.cmake)

#    byd__script__begin("${script_dir}/update.cmake")
#    byd__script__end()
#    byd__build_system__default_update_command(${package})

    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__command("devenv" "/Upgrade" "${ICU_SLN}")
#        byd__script__command("${CMAKE_COMMAND}" -E echo "no configuration step")
    byd__script__end()
    byd__build_system__default_configure_command(${package})

    byd__script__begin("${script_dir}/build.cmake")
        byd__script__command("MSbuild" "/m:${num_jobs}" "/p:Configuration=${CMAKE_BUILD_TYPE}" "/p:PlatformToolset=${ICU_TOOLSET}" "${ICU_SLN}")
    byd__script__end()
    byd__build_system__default_build_command(${package})

    byd__script__begin("${script_dir}/install.cmake")
        byd__script__command("${CMAKE_COMMAND}"
                             "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"
                             "-DICU_SOURCE_DIR=${source_dir}"
                             -P "${script_dir}/${WINDOWS_INSTALL_SCRIPT}")
    byd__script__end()
    byd__build_system__default_install_command(${package})

    byd__EP__add(${package})
    file(
        COPY ${CMAKE_CURRENT_LIST_DIR}/${WINDOWS_INSTALL_SCRIPT}
        DESTINATION ${script_dir}
        )

else()
    byd__package__get_components(${package} components)
    byd__package__get_components_to_build(${package} components_to_build)
    foreach(component IN LISTS components)
        if(component IN_LIST components_to_build)
            set(action enable)
        else()
            set(action disable)
        endif()
        byd__autotool__configure__add_args(${package} --${action}-${component})
    endforeach()

    byd__autotool__configure__add_args(${package} --enable-tests)
    byd__autotool__configure__add_args(${package} --disable-samples)
    byd__autotool__configure__add_args(${package} --enable-rpath)

    byd__package__set_source_sub_dir(${package} "source")
    byd__autotool__configure__set_configure_cmd(${package} "runConfigureICU" ${${package}_PLATFORM})

    if(APPLE)
        byd__fixup_dylib(${package})
    endif()

    byd__autotool__add(${package} TEST_TARGET check)
endif()
