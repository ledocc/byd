


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

    byd__package__get_components_to_build(${package} components_to_build)
    if(components_to_build)
        byd__package__get_components(${package} components)
        cmut_debug("[byd][autotool] - [${package}] : all components = ${components}")
        foreach(component IN LISTS components)
            if(component IN_LIST components_to_build)
                set(action enable)
            else()
                set(action disable)
            endif()
            byd__autotool__configure__add_args(${package} --${action}-${component})
            list(REMOVE_ITEM components_to_build "${component}")
        endforeach()

        if(components_to_build)
            cmut_info("[byd][autotool] - [${package}] : component(s) : ")
            foreach(component IN LISTS components_to_build)
                cmut_info("[byd][autotool] - [${package}] :   - ${component}")
            endforeach()
            cmut_fatal("[byd][autotool] - [${package}] : They are component requested but not provide by package definition.")
        endif()

    endif()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
