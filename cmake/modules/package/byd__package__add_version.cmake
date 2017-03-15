


include("${BYD_ROOT}/cmake/modules/private/byd__private__version_to_name.cmake")



##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##


function(byd__package__add_version__handle_EP_args_1 package)

    byd__set_property(BYD__EP__DOWNLOAD__${ARGV1}__${package} "${ARGV2}")

endfunction()

function(byd__package__add_version__handle_EP_args_2 package)

    byd__set_property(BYD__EP__DOWNLOAD__${ARGV1}__${package} "${ARGV2}" "${ARGV3}")

endfunction()


set(__BYD__EP__ARGS_WITH_2_OPERAND URL_HASH)

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##


function(byd__package__add_version package version)

    __byd__private__version_to_name(${version} version_name)

    set(BYD__PACKAGE__${package}_${version} "${ARGN}" PARENT_SCOPE)
    set(BYD__PACKAGE__DEFAULT_VERSION__${package} "${ARGN}" PARENT_SCOPE)

    set(current_arg_index 2)

    while(current_arg_index LESS ARGC)

        set(idx0 ${current_arg_index})
        math(EXPR idx1 "${idx0} + 1")

        if(${ARGV${current_arg_index}} IN_LIST __BYD__EP__ARGS_WITH_2_OPERAND)
            math(EXPR idx2 "${idx0} + 2")
            byd__package__add_version__handle_EP_args_2(${package} "${ARGV${idx0}}" "${ARGV${idx1}}" "${ARGV${idx2}}")
            set(num_arg_handle 3)
        else()
            byd__package__add_version__handle_EP_args_1(${package} "${ARGV${idx0}}" "${ARGV${idx1}}")
            set(num_arg_handle 2)
        endif()

        math(EXPR current_arg_index "${idx0} + ${num_arg_handle}")

    endwhile()

endfunction()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
