


include("${BYD_ROOT}/cmake/modules/EP.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__default_configure_command package)
    byd__package__get_script_dir(${package} script_dir)
    byd__EP__set_package_argument(${package} CONFIGURE CONFIGURE_COMMAND "${CMAKE_COMMAND}" -P "${script_dir}/configure.cmake")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__default_build_command package)
    byd__package__get_script_dir(${package} script_dir)
    byd__EP__set_package_argument(${package} BUILD BUILD_COMMAND "${CMAKE_COMMAND}" -P "${script_dir}/build.cmake")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__default_install_command package)
    byd__package__get_script_dir(${package} script_dir)
    byd__EP__set_package_argument(${package} INSTALL INSTALL_COMMAND "${CMAKE_COMMAND}" -P "${script_dir}/install.cmake")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__build_system__default_test_command package)
    byd__package__get_script_dir(${package} script_dir)
    byd__EP__set_package_argument(${package} TEST TEST_COMMAND "${CMAKE_COMMAND}" -P "${script_dir}/test.cmake")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
