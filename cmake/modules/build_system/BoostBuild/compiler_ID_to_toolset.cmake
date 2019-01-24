

function( byd__BoostBuild__get_toolset_detail result_name result_version)

    if(MSVC)
        set(BOOST_TOOLSET_NAME msvc)
        if(MSVC_VERSION EQUAL 1200)
            set(BOOST_TOOLSET_VERSION "6.0")
        elseif(MSVC_VERSION EQUAL 1300)
            set(BOOST_TOOLSET_VERSION "7.0")
        elseif(MSVC_VERSION EQUAL 1310)
            set(BOOST_TOOLSET_VERSION "7.1")
        elseif(MSVC_VERSION EQUAL 1400)
            set(BOOST_TOOLSET_VERSION "8.0")
        elseif(MSVC_VERSION EQUAL 1500)
            set(BOOST_TOOLSET_VERSION "9.0")
        elseif(MSVC_VERSION EQUAL 1600)
            set(BOOST_TOOLSET_VERSION "10.0")
        elseif(MSVC_VERSION EQUAL 1700)
            set(BOOST_TOOLSET_VERSION "11.0")
        elseif(MSVC_VERSION EQUAL 1800)
            set(BOOST_TOOLSET_VERSION "12.0")
        elseif(MSVC_VERSION EQUAL 1900)
            set(BOOST_TOOLSET_VERSION "14.0")
        elseif((MSVC_VERSION GREATER_EQUAL 1910) AND (MSVC_VERSION LESS_EQUAL 1919))
            set(BOOST_TOOLSET_VERSION "14.1")
	else()
	    cmut_fatal("[byd][BoostBuild][${package}] - msvc version \"${MSVC_VERSION}\" not supported by byd. patch me if you can!")
	endif()
    elseif(BORLAND)
        set(BOOST_TOOLSET_NAME "bcb")
        set(BOOST_TOOLSET_NAME "bcb")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(BOOST_TOOLSET_NAME "gcc")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(BOOST_TOOLSET_NAME "clang")
    else()
        string(TOLOWER "${CMAKE_CXX_COMPILER_ID}" BOOST_TOOLSET_NAME)
        if(CMAKE_CXX_COMPILER_VERSION MATCHES "([0-9]+)[.]([0-9]+)")
            set(BOOST_TOOLSET_VERSION "${CMAKE_MATCH_1}${CMAKE_MATCH_2}")
        endif()
    endif()

    if(NOT BOOST_TOOLSET_NAME)
        cmut_fatal("[byd][BoostBuild][${package}] - no BOOST_TOOLSET_NAME defined. CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}. patch me if you can!")
    else()
        cmut_info("[byd][BoostBuild][${package}] - BOOST_TOOLSET_NAME = ${BOOST_TOOLSET_NAME}")
    endif()

    set(BOOST_TOOLSET "${BOOST_TOOLSET_NAME}")
    if(BOOST_TOOLSET_VERSION)
        set(BOOST_TOOLSET "${BOOST_TOOLSET}-${BOOST_TOOLSET_VERSION}")
    endif()

    byd__func__return_in(result_name BOOST_TOOLSET_NAME)
    byd__func__return_in(result_version BOOST_TOOLSET_VERSION)

endfunction()



function( byd__BoostBuild__get_toolset result)

    byd__BoostBuild__get_toolset_detail(BOOST_TOOLSET_NAME BOOST_TOOLSET_VERSION)

    set(BOOST_TOOLSET "${BOOST_TOOLSET_NAME}")
    if(BOOST_TOOLSET_VERSION)
        set(BOOST_TOOLSET "${BOOST_TOOLSET}-${BOOST_TOOLSET_VERSION}")
    endif()

    byd__func__return(BOOST_TOOLSET)

endfunction()
