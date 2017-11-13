


include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__standard__define_general_step_parameters)

    set(step_name GENERAL)

    byd__EP__step__set_parameter_source(${step_name} DEPENDS          component_or_package)
    byd__EP__step__set_parameter_source(${step_name} PREFIX           component_or_package)
    byd__EP__step__set_parameter_source(${step_name} LIST_SEPARATOR   component_or_package)
    byd__EP__step__set_parameter_source(${step_name} TMP_DIR          component_or_package)
    byd__EP__step__set_parameter_source(${step_name} STAMP_DIR        component_or_package)
    byd__EP__step__set_parameter_source(${step_name} EXCLUDE_FROM_ALL component_or_package)

endfunction()

function(byd__EP__step__standard__define_download_step_parameters)

    set(step_name DOWNLOAD)


    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_COMMAND     component_or_package)

    byd__EP__step__set_parameter_source(${step_name} URL      component_or_package)
    byd__EP__step__set_parameter_source(${step_name} URL_HASH component_or_package)
    byd__EP__step__set_parameter_source(${step_name} URL_MD5  component_or_package)

    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NAME        component_or_package)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NO_EXTRACT  component_or_package)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NO_PROGRESS component_or_package_or_default)

    byd__EP__step__set_parameter_source(${step_name} TIMEOUT component_or_package_or_default)


    byd__EP__step__set_parameter_source(${step_name} HTTP_USERNAME component_or_package)
    byd__EP__step__set_parameter_source(${step_name} HTTP_PASSWORD component_or_package)
    byd__EP__step__set_parameter_source(${step_name} HTTP_HEADER   component_or_package)

    byd__EP__step__set_parameter_source(${step_name} TLS_VERIFY component_or_package)
    byd__EP__step__set_parameter_source(${step_name} TLS_CAINFO component_or_package)


    byd__EP__step__set_parameter_source(${step_name} GIT_REPOSITORY  component_or_package)
    byd__EP__step__set_parameter_source(${step_name} GIT_TAG         component_or_package)
    byd__EP__step__set_parameter_source(${step_name} GIT_REMOTE_NAME component_or_package)
    byd__EP__step__set_parameter_source(${step_name} GIT_SUBMODULES  component_or_package)
    byd__EP__step__set_parameter_source(${step_name} GIT_SHALLOW     component_or_package_or_default)
    byd__EP__step__set_parameter_source(${step_name} GIT_PROGRESS    component_or_package)
    byd__EP__step__set_parameter_source(${step_name} GIT_CONFIG      component_or_package)


    byd__EP__step__set_parameter_source(${step_name} SVN_REPOSITORY component_or_package)
    byd__EP__step__set_parameter_source(${step_name} SVN_REVISION   component_or_package)
    byd__EP__step__set_parameter_source(${step_name} SVN_USERNAME   component_or_package)
    byd__EP__step__set_parameter_source(${step_name} SVN_PASSWORD   component_or_package)
    byd__EP__step__set_parameter_source(${step_name} SVN_TRUST_CERT component_or_package)


    byd__EP__step__set_parameter_source(${step_name} HG_REPOSITORY component_or_package)
    byd__EP__step__set_parameter_source(${step_name} HG_TAG        component_or_package)


    byd__EP__step__set_parameter_source(${step_name} CVS_REPOSITORY component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CVS_MODULE     component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CVS_TAG        component_or_package)


    byd__EP__set_default_argument(${step_name} DOWNLOAD_NO_PROGRESS 0)
    byd__EP__set_default_argument(${step_name} GIT_SHALLOW 1)

endfunction()

function(byd__EP__step__standard__define_update_step_parameters)

    set(step_name UPDATE)

    byd__EP__step__set_parameter_source(${step_name} UPDATE_COMMAND      component_or_package)
    byd__EP__step__set_parameter_source(${step_name} UPDATE_DISCONNECTED component_or_package)
    byd__EP__step__set_parameter_source(${step_name} PATCH_COMMAND       component_or_package)

endfunction()

function(byd__EP__step__standard__define_configure_step_parameters)

    set(step_name CONFIGURE)

    byd__EP__step__set_parameter_source(${step_name} SOURCE_DIR               component_or_package)
    byd__EP__step__set_parameter_source(${step_name} SOURCE_SUBDIR            component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CONFIGURE_COMMAND        component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_COMMAND            component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR          component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR_PLATFORM component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR_TOOLSET  component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_ARGS               component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_CACHE_ARGS         component_or_package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_CACHE_DEFAULT_ARGS component_or_package)

    ## no default for CONFIGURE_COMMAND, in case of cmake build system, CONFIGURE_COMMAND is and should remain not defined
#    byd__EP__set_default_argument(${step_name} CONFIGURE_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no configure step")

endfunction()

function(byd__EP__step__standard__define_build_step_parameters)

    set(step_name BUILD)

    byd__EP__step__set_parameter_source(${step_name} BINARY_DIR       component_or_package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_COMMAND    component_or_package_or_default)
    byd__EP__step__set_parameter_source(${step_name} BUILD_IN_SOURCE  component_or_package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_ALWAYS     component_or_package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_BYPRODUCTS component_or_package)

    byd__EP__set_default_argument(${step_name} BUILD_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no build step")

endfunction()

function(byd__EP__step__standard__define_install_step_parameters)

    set(step_name INSTALL)

    byd__EP__step__set_parameter_source(${step_name} INSTALL_DIR     component_or_package)
    byd__EP__step__set_parameter_source(${step_name} INSTALL_COMMAND component_or_package_or_default)

    byd__EP__set_default_argument(${step_name} INSTALL_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no install step")

endfunction()

function(byd__EP__step__standard__define_test_step_parameters)

    set(step_name TEST)

    byd__EP__step__set_parameter_source(${step_name} TEST_BEFORE_INSTALL    default)
    byd__EP__step__set_parameter_source(${step_name} TEST_AFTER_INSTALL     default)
    byd__EP__step__set_parameter_source(${step_name} TEST_EXCLUDE_FROM_MAIN component_or_package)
    byd__EP__step__set_parameter_source(${step_name} TEST_COMMAND           component_or_package_or_default)

    byd__EP__set_default_argument(${step_name} TEST_BEFORE_INSTALL 1)
    byd__EP__set_default_argument(${step_name} TEST_COMMAND "${CMAKE_COMMAND}" "-E" "echo" "no test step")

endfunction()

function(byd__EP__step__standard__define_log_step_parameters)

    set(step_name LOG)

    set(args
        LOG_DOWNLOAD
        LOG_UPDATE
        LOG_CONFIGURE
        LOG_BUILD
        LOG_TEST
        LOG_INSTALL
        )

    foreach(arg IN LISTS args)
        byd__EP__step__set_parameter_source(${step_name} ${arg} component_or_package_or_default)
        byd__EP__set_default_argument(${step_name} ${arg} ${BYD__OPTION__LOG_STEP})
    endforeach()

endfunction()

function(byd__EP__step__provider__define_step_info)

    byd__EP__step__is_step_info_defined(STANDARD is_defined)
    if(is_defined)
        return()
    endif()

    byd__EP__step__standard__define_general_step_parameters()
    byd__EP__step__standard__define_download_step_parameters()
    byd__EP__step__standard__define_update_step_parameters()
    byd__EP__step__standard__define_configure_step_parameters()
    byd__EP__step__standard__define_build_step_parameters()
    byd__EP__step__standard__define_install_step_parameters()
    byd__EP__step__standard__define_test_step_parameters()
    byd__EP__step__standard__define_log_step_parameters()

    byd__EP__step__set_step_info_defined(STANDARD)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
