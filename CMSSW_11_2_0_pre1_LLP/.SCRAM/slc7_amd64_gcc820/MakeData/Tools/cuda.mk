ALL_TOOLS      += cuda
ALL_LIB_TYPES += CUDA_LIB
cuda_EX_INCLUDE := /cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/10.2.89-bcolbf2/include
cuda_EX_LIB := cudart cudadevrt nvToolsExt
cuda_EX_CUDA_LIB := cudadevrt
cuda_EX_USE := cuda-stubs
cuda_EX_FLAGS_CUDA_HOST_CXXFLAGS  := -std=c++14
cuda_EX_FLAGS_CUDA_FLAGS  := -std=c++14 -O3 --generate-line-info --source-in-ptx --expt-relaxed-constexpr --expt-extended-lambda -gencode arch=compute_35,code=sm_35 -gencode arch=compute_60,code=sm_60 -gencode arch=compute_70,code=sm_70 -Xcudafe --diag_suppress=esa_on_defaulted_function_ignored --cudart shared
cuda_EX_FLAGS_CUDA_HOST_REM_CXXFLAGS  := -std=% %potentially-evaluated-expression

