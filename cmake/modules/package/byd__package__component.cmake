


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")

include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")

include("${BYD_ROOT}/cmake/modules/private/byd__private__assert_not_empty.cmake")

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


function(byd__package__assert_no_component package function_name)

    byd__package__split_package_component_name(${package} package_name component_name)
    byd__private__assert_empty("${component_name}" "[byd] - ${function_name} don't accept package with component : package = ${package}.")

endfunction()


function(byd__package__get_package_component_name_separator result)
    byd__func__return_value("--")
endfunction()


function(byd__package__make_package_component_name package_name component_name result)
    byd__package__get_package_component_name_separator(separator)
    byd__func__return_value("${package_name}${separator}${component_name}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__convert_package_to_package_component_name package result)

    byd__package__get_package_component_name_separator(separator)
    string(REPLACE "${separator}" ";" package_and_component "${package}")


    byd__func__return(package_and_component)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__get_package_name_from_package_and_component_list package_and_component result )

    list(GET package_and_component 0 package_name)
    byd__func__return(package_name)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(__byd__package__get_component_name_from_package_and_component_list package_and_component result )

    list(GET package_and_component 1 component_name)
    byd__func__return(component_name)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_package_name package result)

    __byd__package__convert_package_to_package_component_name(${package} package_and_component)
    byd__private__assert_not_empty("${package_and_component}")

    __byd__package__get_package_name_from_package_and_component_list("${package_and_component}" package_name)
    byd__func__return(package_name)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__get_component_name package result)

    __byd__package__convert_package_to_package_component_name(${package} package_and_component)
    list(LENGTH package_and_component package_and_component_num_element)

    if(package_and_component_num_element EQUAL 2)
        __byd__package__get_component_name_from_package_and_component_list("${package_and_component}" component_name)
    else()
        set(component_name)
    endif()
    byd__func__return(component_name)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__package__split_package_component_name package package_name component_name)

    __byd__package__convert_package_to_package_component_name(${package} package_and_component)

    list(LENGTH package_and_component package_and_component_num_element)
    if(package_and_component_num_element EQUAL 1)
        set(package_name ${package} PARENT_SCOPE)
        set(component_name "" PARENT_SCOPE)
        return()
    elseif(package_and_component_num_element EQUAL 2)
        __byd__package__get_package_name_from_package_and_component_list("${package_and_component}" package_name)
        set(package_name ${package_name} PARENT_SCOPE)

        __byd__package__get_component_name_from_package_and_component_list("${package_and_component}" component_name)
        set(component_name ${component_name} PARENT_SCOPE)

        return()
    else()
        cmut_fatal("[byd][package] - : \"${package}\" : invalid format, should be <package>::<component>.")
    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
