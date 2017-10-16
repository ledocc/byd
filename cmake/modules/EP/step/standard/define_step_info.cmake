


include("${BYD_ROOT}/cmake/modules/EP/step/step_info.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__step__standard__define_general_step_parameters)

    set(step_name GENERAL)

    byd__EP__step__set_parameter_source(${step_name} DEPENDS          package)
    byd__EP__step__set_parameter_source(${step_name} PREFIX           package)
    byd__EP__step__set_parameter_source(${step_name} LIST_SEPARATOR   package)
    byd__EP__step__set_parameter_source(${step_name} TMP_DIR          package)
    byd__EP__step__set_parameter_source(${step_name} STAMP_DIR        package)
    byd__EP__step__set_parameter_source(${step_name} EXCLUDE_FROM_ALL package)

endfunction()

function(byd__EP__step__standard__define_download_step_parameters)

    set(step_name DOWNLOAD)

    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NAME        package)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_DIR         package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_COMMAND     package)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NO_PROGRESS package_or_default)

    byd__EP__step__set_parameter_source(${step_name} CVS_REPOSITORY package)
    byd__EP__step__set_parameter_source(${step_name} CVS_MODULE     package)
    byd__EP__step__set_parameter_source(${step_name} CVS_TAG        package)

    byd__EP__step__set_parameter_source(${step_name} SVN_REPOSITORY package)
    byd__EP__step__set_parameter_source(${step_name} SVN_REVISION   package)
    byd__EP__step__set_parameter_source(${step_name} SVN_USERNAME   package)
    byd__EP__step__set_parameter_source(${step_name} SVN_PASSWORD   package)
    byd__EP__step__set_parameter_source(${step_name} SVN_TRUST_CERT package)

    byd__EP__step__set_parameter_source(${step_name} GIT_REPOSITORY  package)
    byd__EP__step__set_parameter_source(${step_name} GIT_TAG         package)
    byd__EP__step__set_parameter_source(${step_name} GIT_REMOTE_NAME package)
    byd__EP__step__set_parameter_source(${step_name} GIT_SUBMODULES  package)
    byd__EP__step__set_parameter_source(${step_name} GIT_SHALLOW     package)

    byd__EP__step__set_parameter_source(${step_name} HG_REPOSITORY package)
    byd__EP__step__set_parameter_source(${step_name} HG_TAG        package)

    byd__EP__step__set_parameter_source(${step_name} URL      package)
    byd__EP__step__set_parameter_source(${step_name} URL_HASH package)
    byd__EP__step__set_parameter_source(${step_name} URL_MD5  package)

    byd__EP__step__set_parameter_source(${step_name} HTTP_USERNAME package)
    byd__EP__step__set_parameter_source(${step_name} HTTP_PASSWORD package)
    byd__EP__step__set_parameter_source(${step_name} HTTP_HEADER   package)

    byd__EP__step__set_parameter_source(${step_name} TLS_VERIFY package)
    byd__EP__step__set_parameter_source(${step_name} TLS_CAINFO package)

    byd__EP__step__set_parameter_source(${step_name} TIMEOUT             package_or_default)
    byd__EP__step__set_parameter_source(${step_name} DOWNLOAD_NO_EXTRACT package)

endfunction()

function(byd__EP__step__standard__define_update_step_parameters)

    set(step_name UPDATE)

    byd__EP__step__set_parameter_source(${step_name} UPDATE_COMMAND      package)
    byd__EP__step__set_parameter_source(${step_name} UPDATE_DISCONNECTED package)
    byd__EP__step__set_parameter_source(${step_name} PATCH_COMMAND       package)

endfunction()

function(byd__EP__step__standard__define_configure_step_parameters)

    set(step_name CONFIGURE)

    byd__EP__step__set_parameter_source(${step_name} SOURCE_DIR               package)
    byd__EP__step__set_parameter_source(${step_name} SOURCE_SUBDIR            package)
    byd__EP__step__set_parameter_source(${step_name} CONFIGURE_COMMAND        package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_COMMAND            package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR          package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR_PLATFORM package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_GENERATOR_TOOLSET  package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_ARGS               package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_CACHE_ARGS         package)
    byd__EP__step__set_parameter_source(${step_name} CMAKE_CACHE_DEFAULT_ARGS package)


endfunction()

function(byd__EP__step__standard__define_build_step_parameters)

    set(step_name BUILD)

    byd__EP__step__set_parameter_source(${step_name} BINARY_DIR       package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_COMMAND    package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_IN_SOURCE  package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_ALWAYS     package)
    byd__EP__step__set_parameter_source(${step_name} BUILD_BYPRODUCTS package)

endfunction()

function(byd__EP__step__standard__define_install_step_parameters)

    set(step_name INSTALL)

    byd__EP__step__set_parameter_source(${step_name} INSTALL_DIR     package)
    byd__EP__step__set_parameter_source(${step_name} INSTALL_COMMAND package)

endfunction()

function(byd__EP__step__standard__define_test_step_parameters)

    set(step_name TEST)

    byd__EP__step__set_parameter_source(${step_name} TEST_BEFORE_INSTALL    default)
    byd__EP__step__set_parameter_source(${step_name} TEST_AFTER_INSTALL     default)
    byd__EP__step__set_parameter_source(${step_name} TEST_EXCLUDE_FROM_MAIN package)
    byd__EP__step__set_parameter_source(${step_name} TEST_COMMAND           package_or_default)

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
        byd__EP__step__set_parameter_source(${step_name} ${arg} package_or_default)
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
