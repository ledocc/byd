


include("${CMUT_ROOT}/cmut_message.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__info package)

    cmut__utils__parse_arguments(
        byd__package__info
        __BYD__PACKAGE__INFO_ARG
        ""
        "MAINTAINER_NAME;MAINTAINER_EMAIL;VERSION;ABI"
        ""
        ${ARGN}
        )

    if(DEFINED __BYD__PACKAGE__INFO_ARG_MAINTAINER_NAME)
        byd__package__set_maintainer_name(${package} ${__BYD__PACKAGE__INFO_ARG_MAINTAINER_NAME})
    endif()

    if(DEFINED __BYD__PACKAGE__INFO_ARG_MAINTAINER_EMAIL)
        byd__package__set_maintainer_email(${package} ${__BYD__PACKAGE__INFO_ARG_MAINTAINER_EMAIL})
    endif()


    if(DEFINED __BYD__PACKAGE__INFO_ARG_VERSION)
        byd__package__set_version(${package} ${__BYD__PACKAGE__INFO_ARG_VERSION})
    else()
        cmut_error("[byd][package] - [${package}] : byd__package__info : VERSION argument required.")
    endif()


    if(DEFINED __BYD__PACKAGE__INFO_ARG_ABI)
        byd__package__set_abi(${package} ${__BYD__PACKAGE__INFO_ARG_ABI})
    else()
        byd__package__set_abi(${package} ${__BYD__PACKAGE__INFO_ARG_VERSION})
    endif()


endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__download_info package)

    byd__package__set_download_args(${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  MAINTAINER_NAME  -------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_maintainer_name package maintainer_name)

    __byd__package__set_property(MAINTAINER_NAME "${maintainer_name}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_maintainer_name package result)

    __byd__package__get_property(MAINTAINER_NAME maintainer_name)

    byd__func__return(maintainer_name)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  MAINTAINER_EMAIL  ------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_maintainer_email package maintainer_email)

    __byd__package__set_property(MAINTAINER_EMAIL "${maintainer_email}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_maintainer_email package result)

    __byd__package__get_property(MAINTAINER_EMAIL maintainer_email)

    byd__func__return(maintainer_email)

endfunction()

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
##  ABI  -------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_abi package abi)

    __byd__package__set_property(ABI "${abi}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_abi package result)

    __byd__package__get_property(ABI abi)

    byd__func__return(abi)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  DOWNLOAD_ARG  ----------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__set_download_args package)

    __byd__package__set_property(DOWNLOAD_ARGS "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_download_args package result)

    __byd__package__get_property(DOWNLOAD_ARGS args)

    byd__func__return(args)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##  DOWNLOAD_INFO  ---------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__apply_download_info package)

    byd__package__get_download_args(${package} args)

    __byd__package__set_EP_download_arg(${package} ${args})

endfunction()

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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
