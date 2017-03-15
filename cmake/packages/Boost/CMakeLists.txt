set(package Boost)

byd__package__add_version(
    ${package} 1.63.0
    URL "https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.bz2"
    URL_MD5 1c837ecd990bb022d07e7aab32b09847
    )


if(CMAKE_INSTALL_PREFIX)
    if(byd__icu)
        byd__BoostBuild__build__add_args(${package} "-sICU_PATH=${CMAKE_INSTALL_PREFIX}")
    endif()

    if(byd_zlib)
        byd__BoostBuild__build__add_args(${package} "-sZLIB_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sZLIB_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sZLIB_BINARY=zdll")
        endif()
    endif()

    if(bzip2)
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_INCLUDE=${CMAKE_INSTALL_PREFIX}/include")
        byd__BoostBuild__build__add_args(${package} "-sBZIP2_LIBPATH=${CMAKE_INSTALL_PREFIX}/lib")
        if(MSVC)
            byd__BoostBuild__build__add_args(${package} "-sBZIP2_BINARY=bz2")
        endif()
    endif()
endif()



set(BOOST_LIBS_TO_BUILD
#	atomic
#	chrono
#	container
#	context
#	coroutine
#	coroutine2
	#date_time
	exception
#	fiber
	#filesystem
#	graph
#	graph_parallel
	#iostreams
	#locale
	#log
#	math
#	metaparse
#	mpi
	#program_options
#	python
#	random
	#regex
#	serialization
#	signals
	#system
	#test
#	thread
	#timer
#	type_erasure
#	wave
)
foreach (lib ${BOOST_LIBS_TO_BUILD})
	byd__BoostBuild__build__add_args(${package} "--with-${lib}")
endforeach()

byd__EP__compile_in_source(${package} ON)
byd__BoostBuild__add(${package})


#ExternalProject_Get_Property(Boost SOURCE_DIR)

#set(ENV{BOOST_BUILD_PATH} ${SOURCE_DIR})
#configure_file(user-config.jam.in ${SOURCE_DIR}/user-config.jam)
