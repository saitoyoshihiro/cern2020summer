ALL_TOOLS      += clhepheader
clhepheader_EX_INCLUDE := /cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/clhep/2.4.1.3-ghbfee/include
clhepheader_EX_USE := root_cxxdefaults
clhepheader_EX_FLAGS_ROOTCLING_ARGS  := -moduleMapFile=$(CLHEP_BASE)/include/module.modulemap

