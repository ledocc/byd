


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")

include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_component package)

    __byd__package__add_to_property(COMPONENTS "${ARGN}")

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__is_component package component result)

    cmut__utils__parse_arguments(byd__package__is_component
        PARAM
        ""
        "VERSION"
        ""
        ${ARGN}
        )

    __byd__package__get_property(COMPONENTS components)
    if(NOT component IN_LIST components)
        byd__func__return_value(FALSE)
    endif()

    if(PARAM_VERSION)
        __byd__package__get_property(COMPONENT_${component} version)
        if(PARAM_VERSION VERSION_LESS version)
            byd__func__return_value(FALSE)
        endif()
    endif()

    byd__func__return_value(TRUE)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_components package result)

    __byd__package__get_property(COMPONENTS components)
    byd__func__return(components)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_components_to_build package components)

    __byd__package__add_to_property(COMPONENTS_TO_BUILD "${components}")

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
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
