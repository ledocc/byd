

function(byd__EP__define_step_info)

    file(GLOB step_paths
        "${BYD_ROOT}/cmake/modules/EP/step/*/define_step_info.cmake"
        )

    foreach(path IN LISTS step_paths)
        byd__EP__debug("include( ${path} )")
        include("${path}")
        byd__EP__step__provider__define_step_info()
    endforeach()

endfunction()
