


include("${BYD_ROOT}/cmake/modules/package/byd__package__property.cmake")



function(byd__package__define_dependency package)

    __byd__package__set_property(DEPENDENCY "${ARGN}")

endfunction()

function(byd__package__get_dependency package result)

    __byd__package__get_property(DEPENDENCY dependency)
    set(${result} "${dependency}" PARENT_SCOPE)

endfunction()
