


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")
include("${CMUT_ROOT}/cmut_message.cmake")

include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


function(byd__package__info package)

    cmut__utils__parse_arguments(
        byd__package__info
        __BYD__PACKAGE__INFO_ARG
        ""
        "MAINTAINER_NAME;MAINTAINER_EMAIL;VERSION;BUILD_ID;ABI"
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


    if(DEFINED __BYD__PACKAGE__INFO_ARG_BUILD_ID)
        byd__package__set_build_id(${package} ${__BYD__PACKAGE__INFO_ARG_BUILD_ID})
    else()
        byd__package__set_build_id(${package} ${__BYD__PACKAGE__INFO_ARG_VERSION})
    endif()


    if(DEFINED __BYD__PACKAGE__INFO_ARG_ABI)
        byd__package__set_abi(${package} ${__BYD__PACKAGE__INFO_ARG_ABI})
    else()
        byd__package__set_abi(${package} ${__BYD__PACKAGE__INFO_ARG_VERSION})
    endif()


endfunction()


function(byd__package__download_info package)

    byd__package__set_download_args(${package} ${ARGN})

endfunction()
