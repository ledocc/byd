


function(__byd__is_dependencies_defined name result)

    get_property(__result GLOBAL PROPERTY BYD__${name}_DEPENDENCIES SET)

    set(${result} ${__result} PARENT_SCOPE)

endfunction()



function(byd__package__define_dependencies name)

    cmut_debug("byd__package__define_dependencies(${name}) -- begin")

    set(__depends)
    foreach(dependency ${ARGN})
        if(BYD__${dependency})
            list(APPEND __depends "${dependency}")
        endif()
    endforeach()

    byd__set_property(BYD__${name}_DEPENDENCIES "${__depends}")
    byd__set_property(BYD__EP__GENERAL__DEPENDS__${name} "${__depends}")

    cmut_debug("byd__package__define_dependencies : result = ${__depends}")
    cmut_debug("byd__package__define_dependencies(${name}) -- end")

endfunction()
