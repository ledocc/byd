


include("${BYD_ROOT}/cmake/modules/EP/byd__EP__arg.cmake")
include("${BYD_ROOT}/cmake/modules/EP/step/custom_patch/enable.cmake")
include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__custom_patch package patchList__)

    foreach(patch IN LISTS ${patchList__})
        list(APPEND byd__custom_patch__command__${package}
            COMMAND git apply --ignore-whitespace --ignore-space-change --verbose "${patch}"
            )
    endforeach()

    byd__EP__set_package_argument(${package}
        CUSTOM_PATCH COMMAND
        ${byd__custom_patch__command__${package}}
        )


    byd__package__get_source_dir(${package} source_dir)
    byd__EP__set_package_argument(${package}
        CUSTOM_PATCH WORKING_DIRECTORY
        "${source_dir}"
        )

    byd__EP__step__custom_patch__enable(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
