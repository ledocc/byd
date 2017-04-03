
function(copy_directory_contents dir_name dst_name)
    
    file(GLOB _FILES ${dir_name}/*)
        
    if(NOT EXISTS ${dst_name})
        file(MAKE_DIRECTORY ${dst_name})
    endif()
    
    file(
        INSTALL ${_FILES}
        DESTINATION ${dst_name}
        )
        
endfunction()


if(NOT CMAKE_INSTALL_PREFIX)
    message(FATAL "CMAKE_INSTALL_PREFIX not defined. abort")
endif()
if(NOT ICU_SOURCE_DIR)
    message(FATAL "ICU_SOURCE_DIR not defined. abort")
endif()


copy_directory_contents(${ICU_SOURCE_DIR}/include ${CMAKE_INSTALL_PREFIX}/include)
copy_directory_contents(${ICU_SOURCE_DIR}/bin ${CMAKE_INSTALL_PREFIX}/bin)
copy_directory_contents(${ICU_SOURCE_DIR}/lib ${CMAKE_INSTALL_PREFIX}/lib)