ALL_COMMONRULES += src_SimGeneral_MixingModule_test
src_SimGeneral_MixingModule_test_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_test,src/SimGeneral/MixingModule/test,TEST))
