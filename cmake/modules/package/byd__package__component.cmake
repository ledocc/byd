


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__add_component package component)

    cmut__utils__parse_arguments(byd__package__add_component
        PARAM
        ""
        "VERSION"
        ""
        ${ARGN}
        )

    __byd__package__append_property(COMPONENTS "${component}")
    if(PARAM_VERSION)
        __byd__package__set_property(COMPONENT_${component} "${version}")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__is_component package component result)

    cmut__utils__parse_arguments(byd__package__add_component
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
