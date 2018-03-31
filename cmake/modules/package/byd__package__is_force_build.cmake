


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")

include("${BYD_ROOT}/cmake/modules/private/byd__private__assert_not_empty.cmake")

include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")



function(byd__package__is_force_build result package )

    if( NOT BYD__OPTION__FORCE_BUILD )
        byd__func__return_value( 0 )
        return()
    endif()

    if( "${BYD__OPTION__FORCE_BUILD__PACKAGE_LIST}" STREQUAL "")
        byd__func__return_value( 1 )
        return()
    endif()

    if( "${package}" IN_LIST BYD__OPTION__FORCE_BUILD__PACKAGE_LIST )
        byd__func__return_value( 1 )
        return()
    endif()

    byd__package__get_package_name("${package}" package_name)
    if( "${package_name}" IN_LIST BYD__OPTION__FORCE_BUILD__PACKAGE_LIST )
        byd__func__return_value( 1 )
        return()
    endif()

    byd__func__return_value( 0 )

endfunction()
