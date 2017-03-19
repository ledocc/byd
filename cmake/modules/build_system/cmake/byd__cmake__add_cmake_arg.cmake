

function(byd__cmake__add_cmake_arg package variable value)

    byd__func__add_to_property(BYD__EP__CONFIGURE__CMAKE_ARGS__${package} "-D${variable}=${value}")

endfunction()
