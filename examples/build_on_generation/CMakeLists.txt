cmake_minimum_required(VERSION 3.7.2)
cmake_policy(VERSION 3.7)


project(example_zlib VERSION 0.1)


get_filename_component(BYD_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
include("${BYD_ROOT}/byd.cmake")


byd__generate_and_build("${BYD_ROOT}/examples/zlib")
