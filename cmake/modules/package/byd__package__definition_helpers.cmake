

function(byd__package__check_component package)

    cmut_debug("package = ${package}")
    byd__package__split_package_component_name(${package} package_name component_name)

    cmut_debug("package_name = ${package_name}, component_name = ${component_name}")

    byd__package__assert_not_empty_component(${package_name} ${component_name})
    byd__package__assert_component_exists(${package_name} ${component_name})

endfunction()

function(byd__package__assert_not_empty_component package_name component_name)

    byd__private__is_empty(component_name is_empty_component_name)

    if(is_empty_component_name)
        cmut_fatal("[byd][package] - [${package_name}] : no component to build.")
    endif()

endfunction()



function(byd__package__assert_component_exists package_name component_name)

    byd__package__get_components(${package_name} components)
    if(NOT component_name IN_LIST components)
        cmut_fatal("[byd][package] - [${package_name}] : component \"${component_name}\" requested but not provided by package definition.")
    endif()

endfunction()
