

function(byd__find_package_directory package result)

    list(APPEND BYD__PACKAGES_DIR "${BYD_ROOT}/packages")

    set(package_dir "")

    foreach(dir ${BYD__PACKAGES_DIR})

        file(GLOB glob_result
            LIST_DIRECTORIES true
            RELATIVE ${dir}
            "${dir}/*"
            )

        if(package IN_LIST glob_result)
            set(package_dir "${dir}/${package}")
        endif()

    endforeach()


    if(package_dir)
        set(${result} "${package_dir}" PARENT_SCOPE)
    else()
        cmut_fatal("[byd] - [${package}] : info directory not found.")
    endif()

endfunction()
