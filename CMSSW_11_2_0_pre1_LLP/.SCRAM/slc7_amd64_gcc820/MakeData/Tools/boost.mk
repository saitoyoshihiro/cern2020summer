ALL_TOOLS      += boost
boost_EX_INCLUDE := /cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/boost/1.72.0-ghbfee/include
boost_EX_LIB := boost_thread boost_date_time
boost_EX_USE := root_cxxdefaults sockets
boost_EX_FLAGS_CPPDEFINES  := -DBOOST_SPIRIT_THREADSAFE -DPHOENIX_THREADSAFE -DBOOST_MATH_DISABLE_STD_FPCLASSIFY -DBOOST_UUID_RANDOM_PROVIDER_FORCE_POSIX
boost_EX_FLAGS_CXXFLAGS  := -Wno-error=unused-variable

