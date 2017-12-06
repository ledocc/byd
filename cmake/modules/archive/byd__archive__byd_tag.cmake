

include("${CMUT_ROOT}/utils/cmut__utils__directory.cmake")

include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")



##----------------------------------------------------------------------------##
##----------------------------------------------------------------------------##
##----------------------------------------------------------------------------##

function(byd__archive__get_byd_tag_file package result)

    byd__package__get_root_dir(${package} root_dir)
    byd__func__return_value("${root_dir}/${package}.tag")

endfunction()

##----------------------------------------------------------------------------##

function(byd__archive__byd_tag_mismatch)
    byd__func__set_property(BYD__ARCHIVE__BYD_TAG_MISMATCH 1)
endfunction()

##----------------------------------------------------------------------------##

function(byd__archive__is_byd_tag_mismatch result)
    byd__func__get_property(BYD__ARCHIVE__BYD_TAG_MISMATCH mismatch)
    byd__func__return(mismatch)
endfunction()

##----------------------------------------------------------------------------##

function(byd__archive__remove_previous_build_if_byd_tag_not_match package)

    byd__archive__get_byd_tag_file(${package} byd_tag_file)

    if (NOT EXISTS "${byd_tag_file}")
        return()
    endif()


    file(READ "${byd_tag_file}" byd_tag)
    byd__archive__get_package_archive_output_dir(${package} archive_path)

    cmut_debug("[byd][archive][byd_tag] - [${package}] : byd_tag      = ${byd_tag}")
    cmut_debug("[byd][archive][byd_tag] - [${package}] : archive_path = ${archive_path}")

    if(byd_tag STREQUAL archive_path)
        return()
    endif()


    byd__package__get_root_dir(${package} root_dir)
    cmut__utils__rmdir(${root_dir})

    byd__archive__byd_tag_mismatch()

endfunction()

##----------------------------------------------------------------------------##

function(byd__archive__add_byd_tag package)

    byd__archive__get_byd_tag_file(${package} byd_tag_file)

    byd__archive__get_package_archive_output_dir(${package} archive_path)
    file(WRITE "${byd_tag_file}" "${archive_path}")

endfunction()

##----------------------------------------------------------------------------##
##----------------------------------------------------------------------------##
##----------------------------------------------------------------------------##
