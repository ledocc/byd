

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


##---------------------------------------------------------------------------------------------------------------------##
##  ID  ---------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##

macro(__byd__package__define_id_param param)
    __byd__package__set_property(${param} "${PARAM_${param}}")
endmacro()


# byd__package__set_id(package
#     URL package_url
#     MAINTAINER_NAME package_maintainer_name
#     MAINTAINER_EMAIL package_maintainer_email
# )
#
# define :
#        BYD__PACKAGE__URL__<package>,
#        BYD__PACKAGE__MAINTAINER_NAME__<package>
#        BYD__PACKAGE__MAINTAINER_EMAIL__<package>

function(byd__package__set_id package)

    cmut__utils__parse_arguments(
        byd__package__set_id
        PARAM
        ""
        "URL;MAINTAINER_NAME;MAINTAINER_EMAIL"
        ""
        )

    __byd__package__define_id_param(URL)
    __byd__package__define_id_param(MAINTAINER_NAME)
    __byd__package__define_id_param(MAINTAINER_EMAIL)

endfunction()



##--------------------------------------------------------------------------------------------------------------------##
##  DEFAULT_VERSION  -------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_default_version package version)
    __byd__package__set_property(DEFAULT_VERSION "${version}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_default_version package result)
    __byd__package__get_property(DEFAULT_VERSION version)
    byd__func__return(version)
endfunction()



##--------------------------------------------------------------------------------------------------------------------##
##  VERSION_TO_BUILD  ------------------------------------------------------------------------------------------------##
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

function(byd__package__set_version_to_build package version)
    byd__private__assert_not_empty("${version}")

    __byd__package__get_property(VERSION_TO_BUILD current_version_to_build)
    if(current_version_to_build)
        if(NOT version STREQUAL current_version_to_build)
            cmut_fatal("[byd][package] - [${package}] : version to build \"${version}\" not match current one \"${current_version_to_build}\".")
            return()
        endif()
    endif()

    __byd__package__set_property(VERSION_TO_BUILD "${version}")

    __byd__private__version_to_name(${version} version_name)
    __byd__package__get_property(${version_name} version_info)

    __byd__package__set_EP_download_arg(${package} ${version_info})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_version_to_build package result)

    __byd__package__get_property(VERSION_TO_BUILD version)
    byd__func__return(version)

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
##  SCRIPT_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_script_dir package result)

    byd__package__get_prefix(${package} prefix)

    byd__func__return_value("${prefix}/src/${package}-script")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  SOURCE_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_source_dir package result)

    byd__package__get_prefix(${package} prefix)

    byd__func__return_value("${prefix}/src/${package}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  BUILD_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_build_dir package result)

    byd__package__get_prefix(${package} prefix)
    set(source_dir "${prefix}/src/${package}")

    byd__EP__get_compile_in_source(${package} compile_in_source)
    if(NOT compile_in_source)
        set(source_dir "${source_dir}-build")
    endif()

    byd__func__return(source_dir)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  IS_ADDED  --------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__is_added package result)
    byd__private__is_package_added(${package} added)
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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
