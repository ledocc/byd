


include(ExternalProject)

include("${BYD_ROOT}/cmake/modules/EP/byd__EP__define.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

macro(__byd__EP__accum_step_info step)
    byd__get_property(BYD__EP__${step}_STEP__${package} step_info)
    set(__BYD__EP__${package}_ARGS ${__BYD__EP__${package}_ARGS} ${step_info})
endmacro()
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__EP__add package)

    byd__EP__define_steps(${package})


    __byd__EP__accum_step_info(GENERAL)
    __byd__EP__accum_step_info(DOWNLOAD)
    __byd__EP__accum_step_info(UPDATE)
    __byd__EP__accum_step_info(CONFIGURE)
    __byd__EP__accum_step_info(BUILD)
    __byd__EP__accum_step_info(INSTALL)
    __byd__EP__accum_step_info(TEST)
    __byd__EP__accum_step_info(LOG)


    cmut_debug("[byd][EP] - [${package}] : ExternalProject_Add(${package}")
    foreach(arg IN LISTS __BYD__EP__${package}_ARGS)
        cmut_debug("[byd][EP] - [${package}] :     ${arg}")
    endforeach()
    cmut_debug("[byd][EP] - [${package}] : )")


    ExternalProject_Add(
        ${package}
        ${__BYD__EP__${package}_ARGS}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
