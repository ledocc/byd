

include("${CMUT_ROOT}/cmut_message.cmake")

include("${BYD_ROOT}/cmake/modules/func/byd__func__property.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__assert_not_empty.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__set_property param value)
    byd__private__assert_not_empty(${package})

    byd__func__set_property(BYD__PACKAGE__${param}__${package} "${value}")
endfunction()

function(__byd__package__append_property param value)
    byd__private__assert_not_empty(${package})

    byd__func__add_to_property(BYD__PACKAGE__${param}__${package} "${value}")
endfunction()

function(__byd__package__get_property param result)
    byd__private__assert_not_empty(${package})

    byd__func__get_property(BYD__PACKAGE__${param}__${package} value)
    byd__func__return(value)
endfunction()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##

##--------------------------------------------------------------------------------------------------------------------##
##  VERSION  ---------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_version package version)
    __byd__package__set_property(VERSION "${version}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_version package result)
    __byd__package__get_property(VERSION version)
    byd__func__return(version)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  DOWNLOAD_INFO  ---------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__set_EP_download_arg package)

    set(current_arg_index 1)

    while(current_arg_index LESS ARGC)

        set(idx0 ${current_arg_index})
        math(EXPR idx1 "${idx0} + 1")

        byd__EP__set_package_argument(${package} DOWNLOAD "${ARGV${idx0}}" "${ARGV${idx1}}")

        math(EXPR current_arg_index "${current_arg_index} + 2")

    endwhile()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__apply_download_info package)

    byd__package__get_download_args(${package} args)

    __byd__package__set_EP_download_arg(${package} ${args})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  DOWNLOAD_ARG  --------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_download_args package)
    __byd__package__set_property(DOWNLOAD_ARGS "${ARGN}")
endfunction()

function(byd__package__get_download_args package result)
    __byd__package__get_property(DOWNLOAD_ARGS args)
    byd__func__return(args)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  COMPONENTS_TO_BUILD  ---------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_components_to_build package components)

    __byd__package__append_property(COMPONENTS_TO_BUILD "${components}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_components_to_build package result)

    __byd__package__get_property(COMPONENTS_TO_BUILD components)
    if(NOT components)
        byd__package__get_components(${package} components)
    endif()

    byd__func__return(components)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##  PREFIX  ----------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_prefix package result)

    byd__EP__get_package_argument(${package} GENERAL PREFIX prefix)

    if(NOT prefix)
        set(prefix "${package}-prefix")
    endif()

    if(NOT IS_ABSOLUTE ${prefix})
        set(prefix "${CMAKE_BINARY_DIR}/${prefix}")
    endif()

    byd__func__return(prefix)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  ROOT_DIR  ---  ---------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_root_dir package result)

    byd__package__get_prefix(${package} prefix)

    byd__func__return_value("${prefix}/src")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  STAMP_DIR  - -----------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_stamp_dir package result)

    byd__package__get_root_dir(${package} root_dir)

    byd__func__return_value("${root_dir}/${package}-stamp")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  SCRIPT_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_script_dir package result)

    byd__package__get_root_dir(${package} root_dir)

    byd__func__return_value("${root_dir}/${package}-script")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  SOURCE_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_source_dir package result)

    byd__package__get_root_dir(${package} root_dir)

    byd__func__return_value("${root_dir}/${package}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  INSTALL_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_install_dir package result)

    byd__package__get_root_dir(${package} root_dir)

    byd__func__return_value("${root_dir}/${package}-install")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  BUILD_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_build_dir package result)

    byd__package__get_source_dir(${package} source_dir)

    byd__EP__get_compile_in_source(${package} compile_in_source)
    if(NOT compile_in_source)
        set(source_dir "${source_dir}-build")
    endif()

    byd__func__return(source_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  IS_ADDED  --------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_added package)
    __byd__package__set_property(ADDED 1)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__is_added package result)
    __byd__package__get_property(ADDED added)
    byd__func__return(added)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  SOURCE_SUB_DIR  --------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_source_sub_dir package sub_directory)
    __byd__package__set_property(SOURCE_SUB_DIR "${sub_directory}")
endfunction()

function(byd__package__get_source_sub_dir package result)
    __byd__package__get_property(SOURCE_SUB_DIR sub_directory)
    byd__func__return(sub_directory)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  ABI  -------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_abi package abi)
    __byd__package__set_property(ABI "${abi}")
endfunction()

function(byd__package__get_abi package result)
    __byd__package__get_property(ABI abi)
    byd__func__return(abi)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  MAINTAINER_NAME  -------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_maintainer_name package maintainer_name)
    __byd__package__set_property(MAINTAINER_NAME "${maintainer_name}")
endfunction()

function(byd__package__get_maintainer_name package result)
    __byd__package__get_property(MAINTAINER_NAME maintainer_name)
    byd__func__return(maintainer_name)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  MAINTAINER_EMAIL  -------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_maintainer_email package maintainer_email)
    __byd__package__set_property(MAINTAINER_EMAIL "${maintainer_email}")
endfunction()

function(byd__package__get_maintainer_email package result)
    __byd__package__get_property(MAINTAINER_EMAIL maintainer_email)
    byd__func__return(maintainer_email)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
