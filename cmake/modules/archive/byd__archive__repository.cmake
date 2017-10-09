

function(byd__archive__get_default_repository result)

    byd__func__return_value("$ENV{HOME}/.byd")

endfunction()



function(byd__archive__get_repositories result)

    set(repositories "$ENV{BYD__ARCHIVE__REPOSITORIES}")

    list(LENGTH repositories repositories_length)
    if (repositories_length EQUAL 0)
        byd__archive__get_default_repository(repositories)
    endif()

    byd__func__return(repositories)

endfunction()
