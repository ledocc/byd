


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__EP__reset_step package step)
    byd__set_property(BYD__EP__${step}_STEP__${package} "")
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__EP__add_package_arg package step arg)
    byd__EP__get_package_or_default_arg(${package} ${step} ${arg} property_value)
    if(property_value)
        byd__add_to_property(BYD__EP__${step}_STEP__${package} "${arg}" "${property_value}")
    endif()
endmacro()

##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__EP__add_package_or_default_arg package step arg)

    byd__EP__get_package_or_default_arg(${package} ${step} ${arg} property_value)

    if(property_value)
        byd__add_to_property(BYD__EP__${step}_STEP__${package} "${arg}" "${property_value}")
    endif()

endmacro()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_general_step package)

    set(step_name GENERAL)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} DEPENDS)
    __byd__EP__add_package_arg(           ${package} ${step_name} PREFIX)
    __byd__EP__add_package_arg(           ${package} ${step_name} LIST_SEPARATOR)
    __byd__EP__add_package_arg(           ${package} ${step_name} TMP_DIR)
    __byd__EP__add_package_arg(           ${package} ${step_name} STAMP_DIR)
    __byd__EP__add_package_arg(           ${package} ${step_name} EXCLUDE_FROM_ALL)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_download_step package)

    set(step_name DOWNLOAD)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} DOWNLOAD_NAME)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} DOWNLOAD_DIR)
    __byd__EP__add_package_arg(           ${package} ${step_name} DOWNLOAD_COMMAND)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} DOWNLOAD_NO_PROGRESS)

    __byd__EP__add_package_arg(           ${package} ${step_name} CVS_REPOSITORY)
    __byd__EP__add_package_arg(           ${package} ${step_name} CVS_MODULE)
    __byd__EP__add_package_arg(           ${package} ${step_name} CVS_TAG)

    __byd__EP__add_package_arg(           ${package} ${step_name} SVN_REPOSITORY)
    __byd__EP__add_package_arg(           ${package} ${step_name} SVN_REVISION)
    __byd__EP__add_package_arg(           ${package} ${step_name} SVN_USERNAME)
    __byd__EP__add_package_arg(           ${package} ${step_name} SVN_PASSWORD)
    __byd__EP__add_package_arg(           ${package} ${step_name} SVN_TRUST_CERT)

    __byd__EP__add_package_arg(           ${package} ${step_name} GIT_REPOSITORY)
    __byd__EP__add_package_arg(           ${package} ${step_name} GIT_TAG)
    __byd__EP__add_package_arg(           ${package} ${step_name} GIT_REMOTE_NAME)
    __byd__EP__add_package_arg(           ${package} ${step_name} GIT_SUBMODULES)
    __byd__EP__add_package_arg(           ${package} ${step_name} GIT_SHALLOW)

    __byd__EP__add_package_arg(           ${package} ${step_name} HG_REPOSITORY)
    __byd__EP__add_package_arg(           ${package} ${step_name} HG_TAG)

    __byd__EP__add_package_arg(           ${package} ${step_name} URL)
    __byd__EP__add_package_arg(           ${package} ${step_name} URL_HASH)
    __byd__EP__add_package_arg(           ${package} ${step_name} URL_MD5)

    __byd__EP__add_package_arg(           ${package} ${step_name} HTTP_USERNAME)
    __byd__EP__add_package_arg(           ${package} ${step_name} HTTP_PASSWORD)
    __byd__EP__add_package_arg(           ${package} ${step_name} HTTP_HEADER)

    __byd__EP__add_package_arg(           ${package} ${step_name} TLS_VERIFY)
    __byd__EP__add_package_arg(           ${package} ${step_name} TLS_CAINFO)

    __byd__EP__add_package_or_default_arg(${package} ${step_name} TIMEOUT)
    __byd__EP__add_package_arg(           ${package} ${step_name} DOWNLOAD_NO_EXTRACT)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_update_step package)

    set(step_name UPDATE)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} UPDATE_COMMAND)
    __byd__EP__add_package_arg(           ${package} ${step_name} UPDATE_DISCONNECTED)
    __byd__EP__add_package_arg(           ${package} ${step_name} PATCH_COMMAND)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_configure_step package)

    set(step_name CONFIGURE)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} SOURCE_DIR)
    __byd__EP__add_package_arg(           ${package} ${step_name} SOURCE_SUBDIR)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} CONFIGURE_COMMAND)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} CMAKE_COMMAND)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_GENERATOR)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_GENERATOR_PLATFORM)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_GENERATOR_TOOLSET)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_ARGS)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_CACHE_ARGS)
    __byd__EP__add_package_arg(           ${package} ${step_name} CMAKE_CACHE_DEFAULT_ARGS)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_build_step package)

    set(step_name BUILD)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} BINARY_DIR)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} BUILD_COMMAND)
    __byd__EP__add_package_arg(           ${package} ${step_name} BUILD_IN_SOURCE)
    __byd__EP__add_package_arg(           ${package} ${step_name} BUILD_ALWAYS)
    __byd__EP__add_package_arg(           ${package} ${step_name} BUILD_BYPRODUCTS)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_install_step package)

    set(step_name INSTALL)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} INSTALL_DIR)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} INSTALL_COMMAND)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_test_step package)

    set(step_name TEST)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_arg(           ${package} ${step_name} TEST_BEFORE_INSTALL)
    __byd__EP__add_package_arg(           ${package} ${step_name} TEST_AFTER_INSTALL)
    __byd__EP__add_package_arg(           ${package} ${step_name} TEST_EXCLUDE_FROM_MAIN)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} TEST_COMMAND)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_log_step package)

    set(step_name LOG)

    __byd__EP__reset_step(                ${package} ${step_name})
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_DOWNLOAD)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_UPDATE)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_CONFIGURE)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_BUILD)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_TEST)
    __byd__EP__add_package_or_default_arg(${package} ${step_name} LOG_INSTALL)

    byd__get_property(BYD__EP__${step_name}_STEP__${package} __property_value)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__define_steps package)

    byd__EP__define_general_step(${package})

    byd__EP__define_download_step(${package})
    byd__EP__define_update_step(${package})
    byd__EP__define_configure_step(${package})
    byd__EP__define_build_step(${package})
    byd__EP__define_install_step(${package})
    byd__EP__define_test_step(${package})
    byd__EP__define_log_step(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
