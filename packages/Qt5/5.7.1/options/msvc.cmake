
cmut_EP_add_config_arg_if(CMUT_EP_icu -icu -no-icu)

cmut_EP_add_config_arg(-directwrite)
cmut_EP_add_config_arg(-opengl dynamic)
cmut_EP_add_config_arg(-audio-backend)
cmut_EP_add_config_arg(-mp)

cmut_EP_add_config_arg_if(CMAKE_VERBOSE_MAKEFILE -verbose "")
