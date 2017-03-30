


include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")
include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



function(byd__package__set_dependency package)

    __byd__package__set_property(DEPENDENCY "${ARGN}")

endfunction()

function(byd__package__add_dependency package)

    __byd__package__append_property(DEPENDENCY "${ARGN}")

endfunction()

function(byd__package__get_dependency package result)

    __byd__package__get_property(DEPENDENCY dependency)
    byd__func__return(dependency)

endfunction()


function(byd__package__set_component_dependencies package)

    cmut__utils__parse_arguments(byd__package__add_dependency
        PARAM
        ""
        "COMPONENT"
        "DEPENDS"
        ${ARGN}
        )

    if(NOT PARAM_COMPONENT)
        return()
    endif()

    if(NOT PARAM_DEPENDS)
        return()
    endif()

    __byd__package__set_property(DEPENDENCIES__${PARAM_COMPONENT} "${PARAM_DEPENDS}")

endfunction()


function(byd__package__get_component_dependencies package component result)

    __byd__package__get_property(DEPENDENCIES__${component} dependency)
    byd__func__return(dependency)

endfunction()
