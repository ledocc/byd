include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")



if(BUILD_SHARED_LIBS)
    byd__cmake__add_cmake_arg(${package} POCO_STATIC OFF)
else()
    byd__cmake__add_cmake_arg(${package} POCO_STATIC ON)
endif()

byd__cmake__add_cmake_arg(${package} HUNTER_ENABLED OFF)


#byd__cmake__add_option(${package}
#    ENABLE_CPPUNIT OFF
#    ENABLE_MONGODB OFF
#    ENABLE_NETSSL OFF
#    ENABLE_CRYPTO OFF
#    ENABLE_DATA OFF
#    ENABLE_PAGECOMPILER OFF
#    ENABLE_PAGECOMPILER_FILE2PAGE OFF
#    ENABLE_REDIS OFF
#    )



byd__cmake__add(${package} SKIP test)


if(APPLE)
    include("${PROJECT_SOURCE_DIR}/cmake/fixup_dylib.cmake")
    fixup_dylib(${module})
endif()
