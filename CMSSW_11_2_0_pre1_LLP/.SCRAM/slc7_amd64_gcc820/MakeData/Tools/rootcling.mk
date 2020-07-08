ALL_TOOLS      += rootcling
rootcling_EX_INCLUDE := /cvmfs/cms.cern.ch/slc7_amd64_gcc820/lcg/root/6.18.04-ghbfee/include
rootcling_EX_LIB := Core
rootcling_EX_USE := root_interface sockets pcre zlib xz
TOOLS_OVERRIDABLE_FLAGS  +=ROOTCLING_ARGS

