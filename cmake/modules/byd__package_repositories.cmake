


include("${BYD_ROOT}/cmake/modules/func/byd__func__return.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__add_package_repositories)
    cmut_info("[byd] - add package repository : \"${ARGN}\"")
    byd__func__add_to_property(BYD__PACKAGE_REPOSITORIES "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__add_fallback_package_repositories)
    cmut_info("[byd] - add fallback package repository : \"${ARGN}\"")
    byd__func__add_to_property(BYD__FALLBACK_PACKAGE_REPOSITORIES "${ARGN}")
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_package_repositories result)
    byd__func__get_property(BYD__PACKAGE_REPOSITORIES repositories)
    byd__func__return(repositories)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__get_fallback_package_repositories result)
    byd__func__get_property(BYD__FALLBACK_PACKAGE_REPOSITORIES repositories)
    byd__func__return(repositories)
endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
