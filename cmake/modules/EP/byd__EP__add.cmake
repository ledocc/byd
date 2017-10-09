


##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__add package)

    # collect all step
    file(GLOB step_paths
        "${BYD_ROOT}/cmake/modules/EP/step/*/add.cmake"
        )

    # standard step call "ExternalProject_Add" that define a TARGET.
    # other step call "ExternalProject_Add_Step" that require and use the TARGET define by standard step.
    # So standard step have to be defined first
    list(REMOVE_ITEM step_paths "${BYD_ROOT}/cmake/modules/EP/step/standard/add.cmake")
    set(step_paths "${BYD_ROOT}/cmake/modules/EP/step/standard/add.cmake" ${step_paths})


    # add each step
    foreach(path IN LISTS step_paths)
        include("${path}")
        byd__EP__step__provider_add(${package})
    endforeach()

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
