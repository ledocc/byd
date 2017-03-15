
# Transform version string to string acceptable as variable name by cmake
# replace any non alphanum character by '_'
function(__byd__private__version_to_name version result)

    string(REGEX REPLACE "[^0-9a-zA-Z]" "_" __version_result ${version})

    set(${result} ${__version_result} PARENT_SCOPE)

endfunction()
