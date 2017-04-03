include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/component.cmake")



byd__build_system__inject_env_var(${package} UPDATE NOCONFIGURE 1)
byd__autotool__add(${package})
