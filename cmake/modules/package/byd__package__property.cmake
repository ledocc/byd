

include("${BYD_ROOT}/cmake/modules/byd__property.cmake")
include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__assert_not_empty.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__set_property param value)
    byd__private__assert_not_empty(${package})

    byd__set_property(BYD__PACKAGE__${param}__${package} "${value}")
endfunction()

function(__byd__package__get_property param result)
    byd__private__assert_not_empty(${package})

    byd__get_property(BYD__PACKAGE__${param}__${package} value)
    set(${result} "${value}" PARENT_SCOPE)
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
    set(${result} "${version}" PARENT_SCOPE)
endfunction()



##--------------------------------------------------------------------------------------------------------------------##
##  VERSION_TO_BUILD  ------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__set_EP_download_arg package)

    set(current_arg_index 1)

    while(current_arg_index LESS ARGC)

        set(idx0 ${current_arg_index})
        math(EXPR idx1 "${idx0} + 1")

        byd__EP__set_package_arg(${package} DOWNLOAD "${ARGV${idx0}}" "${ARGV${idx1}}")

        math(EXPR current_arg_index "${current_arg_index} + 2")

    endwhile()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_version_to_build package version)
    byd__private__assert_not_empty("${version}")

    __byd__package__set_property(VERSION_TO_BUILD "${version}")

    __byd__private__version_to_name(${version} version_name)
    __byd__package__get_property(${version_name} version_info)

    __byd__package__set_EP_download_arg(${package} ${version_info})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_version_to_build package result)

    __byd__package__get_property(VERSION_TO_BUILD version)
    set(${result} ${version} PARENT_SCOPE)

endfunction()



##--------------------------------------------------------------------------------------------------------------------##
##  COMPONENTS  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_components_to_build package components)

    __byd__package__set_property(COMPONENTS_TO_BUILD "${components}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_components_to_build package result)

    __byd__package__get_property(COMPONENTS_TO_BUILD components)
    set(${result} "${components}" PARENT_SCOPE)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##  PREFIX  ----------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_prefix package result)

    byd__EP__get_package_arg(${package} GENERAL PREFIX prefix)

    if(NOT prefix)
        set(prefix "${package}-prefix")
    endif()

    if(NOT IS_ABSOLUTE ${prefix})
        set(prefix "${CMAKE_BINARY_DIR}/${prefix}")
    endif()

    set(${result} "${prefix}" PARENT_SCOPE)

endfunction()


##--------------------------------------------------------------------------------------------------------------------##
##  SCRIPT_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_script_dir package result)

    byd__package__get_prefix(${package} prefix)

    set(${result} "${prefix}/src/${package}-script" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  SOURCE_DIR  ------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_source_dir package result)

    byd__package__get_prefix(${package} prefix)

    set(${result} "${prefix}/src/${package}" PARENT_SCOPE)

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

    set(${result} "${source_dir}" PARENT_SCOPE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
