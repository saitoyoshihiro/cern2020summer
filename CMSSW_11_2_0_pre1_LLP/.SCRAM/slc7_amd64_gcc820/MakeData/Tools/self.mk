ALL_TOOLS      += self
self_EX_INCLUDE := /afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/src /afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/include/slc7_amd64_gcc820/src /afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/include/LCG /cvmfs/cms.cern.ch/slc7_amd64_gcc820/cms/cmssw/CMSSW_11_2_0_pre1/src /cvmfs/cms.cern.ch/slc7_amd64_gcc820/cms/cmssw/CMSSW_11_2_0_pre1/include/slc7_amd64_gcc820/src /cvmfs/cms.cern.ch/slc7_amd64_gcc820/cms/cmssw/CMSSW_11_2_0_pre1/include/LCG
self_EX_LIBDIR := /afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/lib/slc7_amd64_gcc820 /afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/external/slc7_amd64_gcc820/lib /cvmfs/cms.cern.ch/slc7_amd64_gcc820/cms/cmssw/CMSSW_11_2_0_pre1/lib/slc7_amd64_gcc820 /cvmfs/cms.cern.ch/slc7_amd64_gcc820/cms/cmssw/CMSSW_11_2_0_pre1/external/slc7_amd64_gcc820/lib
self_EX_FLAGS_LLVM_ANALYZER  := llvm-analyzer
self_EX_FLAGS_SKIP_TOOLS_SYMLINK  := cxxcompiler ccompiler f77compiler gcc-cxxcompiler gcc-ccompiler gcc-f77compiler llvm-cxxcompiler llvm-ccompiler llvm-f77compiler llvm-analyzer-cxxcompiler llvm-analyzer-ccompiler icc-cxxcompiler icc-ccompiler icc-f77compiler x11 dpm
self_EX_FLAGS_DEFAULT_COMPILER  := gcc
self_EX_FLAGS_EXTERNAL_SYMLINK  := PATH LIBDIR CMSSW_SEARCH_PATH
TOOLS_OVERRIDABLE_FLAGS  +=CPPDEFINES CXXFLAGS FFLAGS CFLAGS CPPFLAGS LDFLAGS CUDA_FLAGS CUDA_LDFLAGS
self_EX_FLAGS_SYMLINK_DEPTH_CMSSW_SEARCH_PATH  := 2
self_EX_FLAGS_NO_EXTERNAL_RUNTIME  := LD_LIBRARY_PATH PATH CMSSW_SEARCH_PATH
self_EX_FLAGS_SCRAM_VECTORIZE  := avx512f fma avx2
self_ORDER := 20000
IS_PATCH:=

