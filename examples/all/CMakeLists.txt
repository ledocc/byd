cmake_minimum_required(VERSION 3.7.2)
cmake_policy(VERSION 3.7)


project(example_all_cmake VERSION 0.1)


get_filename_component(BYD_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
include("${BYD_ROOT}/byd.cmake")


set(CMUT_DEBUG 1)



set(packages_directory "${BYD_ROOT}/packages")
file(GLOB packages
    LIST_DIRECTORIES true
    RELATIVE "${packages_directory}"
    "${packages_directory}/*"
)

#foreach(package IN LISTS packages)
#    byd__add_package(${package})
#endforeach()

byd__add_package(Boost)

byd__run()
