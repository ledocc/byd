


include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__error_if_property_is_defined.cmake")
include("${BYD_ROOT}/cmake/modules/private/byd__private__num_core_available.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__add_args package)

    byd__func__add_to_property(BYD__AUTOTOOL__CONFIGURE__ARGS__${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__get_args package result)

    byd__func__get_property(BYD__AUTOTOOL__CONFIGURE__ARGS__${package} __result)
    byd__func__return(__result)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__set_configure_cmd package)

    byd__func__set_property(BYD__AUTOTOOL__CONFIGURE__CONFIGURE_CMD__${package} ${ARGN})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__get_configure_cmd package result)

    set(configure_cmd configure)

    byd__func__get_property(BYD__AUTOTOOL__CONFIGURE__CONFIGURE_CMD__${package} custom_configure)
    if(custom_configure)
        set(configure_cmd "${custom_configure}")
    endif()

    byd__func__return(configure_cmd)

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__autotool__configure__add_components_to_arg package)

    byd__package__split_package_component_name(${package} package_name component_name)







    byd__package__get_components(${package_name} components)
    cmut_debug("[byd][autotool] - [${package_name}] : all components = ${components}")
    list(REMOVE_ITEM components ${component_name})
    foreach(component IN LISTS components)
        byd__autotool__configure__add_args(${package} --disable-${component})
    endforeach()
    byd__autotool__configure__add_args(${package} --enable-${component_name})


endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
