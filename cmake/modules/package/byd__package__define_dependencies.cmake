


function(__byd__is_dependencies_defined name result)

    get_property(__result GLOBAL PROPERTY BYD__${name}_DEPENDENCIES SET)

    set(${result} ${__result} PARENT_SCOPE)

endfunction()



function(byd__package__define_dependencies name)

    cmut_debug("byd__package__define_dependencies(${name}) -- begin")

    set(__depends)
    foreach(dependency ${ARGN})
        list(APPEND __depends ${dependency})
    endforeach()

    __byd__is_dependencies_defined(${name} is_dependencies_defined)
    if(NOT is_dependencies_defined)
        define_property(GLOBAL
            PROPERTY BYD__${name}_DEPENDS
            BRIEF_DOCS "${name} dependency list"
            FULL_DOCS  "list of module that ${name} depend")
    endif()
    set_property(GLOBAL PROPERTY BYD__${name}_DEPENDENCIES ${__depends})

    cmut_debug("byd__package__define_dependencies : result = ${__depends}")
    cmut_debug("byd__package__define_dependencies(${name}) -- end")

endfunction()
