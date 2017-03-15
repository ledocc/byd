


include("${CMUT_ROOT}/utils/cmut__utils__parse_arguments.cmake")



##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##

macro(__byd__package__define_id_param param)
    set(BYD__PACKAGE__${param}__${package} "${PARAM_${param}}" PARENT_SCOPE)
endmacro()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##

# byd__package__set_id(package
#     URL package_url
#     MAINTAINER_NAME package_maintainer_name
#     MAINTAINER_EMAIL package_maintainer_email
# )
#
# define :
#        BYD__PACKAGE__URL__<package>,
#        BYD__PACKAGE__MAINTAINER_NAME__<package>
#        BYD__PACKAGE__MAINTAINER_EMAIL__<package>

function(byd__package__set_id package)

    cmut__utils__parse_arguments(
        byd__package__set_id
        PARAM_
        ""
        "URL;MAINTAINER_NAME;MAINTAINER_EMAIL"
        ""
        )

    __byd__package__define_id_param(URL)
    __byd__package__define_id_param(MAINTAINER_NAME)
    __byd__package__define_id_param(MAINTAINER_EMAIL)

endfunction()

##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
##---------------------------------------------------------------------------------------------------------------------##
