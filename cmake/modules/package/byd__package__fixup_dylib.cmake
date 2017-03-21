


include("${BYD_ROOT}/cmake/modules/EP.cmake")



function(byd__package__add_fixup_dylib_step package)

    byd__package__get_script_dir(${package} script_dir)

    byd__EP__step__fixup_dylib(${package} "${script_dir}")

endfunction()

function(byd__package__add_collect_licence_step package)

    byd__package__get_script_dir(${package} script_dir)

    byd__EP__step__fixup_dylib(${package} "${script_dir}")

endfunction()

function(byd__package__add_patch_step package patch_dir)

    byd__package__get_script_dir(${package} script_dir)

    byd__EP__step__fixup_dylib(${package} "${script_dir}")

endfunction()
