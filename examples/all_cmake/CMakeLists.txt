cmake_minimum_required(VERSION 3.7.2)
cmake_policy(VERSION 3.7)


project(example_all_cmake VERSION 0.1)


get_filename_component(BYD_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
include("${BYD_ROOT}/byd.cmake")


set(CMUT_DEBUG 1)


byd__add_package(zlib VERSION 1.2.11-unowhy)
byd__add_package(Poco VERSION 1.7.6-unowhy)
byd__run()
