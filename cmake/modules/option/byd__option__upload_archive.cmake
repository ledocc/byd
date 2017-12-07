

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__option__upload_archive)

    byd__option__private__get_default("BYD__OPTION__UPLOAD_ARCHIVE" "OFF" default_upload_archive)

    option(
        BYD__OPTION__UPLOAD_ARCHIVE 
        "Enable to upload archive on remote repo defined by BYD__OPTION__REMOTE_REPO." 
        ${default_upload_archive}
        )

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
