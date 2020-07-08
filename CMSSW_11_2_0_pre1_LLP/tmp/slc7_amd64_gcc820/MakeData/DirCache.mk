ALL_SUBSYSTEMS+=photons
subdirs_src_photons = src_photons_Analyzer src_photons_stdmodel src_photons_displaced
ALL_SUBSYSTEMS+=SimGeneral
subdirs_src_SimGeneral = src_SimGeneral_MixingModule
ALL_PACKAGES += SimGeneral/MixingModule
subdirs_src_SimGeneral_MixingModule := src_SimGeneral_MixingModule_plugins src_SimGeneral_MixingModule_python src_SimGeneral_MixingModule_src src_SimGeneral_MixingModule_test
ifeq ($(strip $(PySimGeneralMixingModule)),)
PySimGeneralMixingModule := self/src/SimGeneral/MixingModule/python
src_SimGeneral_MixingModule_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/MixingModule/python)
PySimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralMixingModule_LOC_USE := self  
PySimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/python
ALL_PRODS += PySimGeneralMixingModule
PySimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python,src_SimGeneral_MixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_python
src_SimGeneral_MixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_python,src/SimGeneral/MixingModule/python,PYTHON))
ALL_COMMONRULES += src_SimGeneral_MixingModule_test
src_SimGeneral_MixingModule_test_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_test,src/SimGeneral/MixingModule/test,TEST))
ALL_PACKAGES += photons/displaced
subdirs_src_photons_displaced := 
ALL_PACKAGES += photons/stdmodel
subdirs_src_photons_stdmodel := 
ALL_PACKAGES += photons/Analyzer
subdirs_src_photons_Analyzer := src_photons_Analyzer_plugins src_photons_Analyzer_python
ALL_SUBSYSTEMS+=original_RTM_copy
subdirs_src_original_RTM_copy = 
ifeq ($(strip $(PyphotonsAnalyzer)),)
PyphotonsAnalyzer := self/src/photons/Analyzer/python
src_photons_Analyzer_python_parent := 
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/photons/Analyzer/python)
PyphotonsAnalyzer_files := $(patsubst src/photons/Analyzer/python/%,%,$(wildcard $(foreach dir,src/photons/Analyzer/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyphotonsAnalyzer_LOC_USE := self  
PyphotonsAnalyzer_PACKAGE := self/src/photons/Analyzer/python
ALL_PRODS += PyphotonsAnalyzer
PyphotonsAnalyzer_INIT_FUNC        += $$(eval $$(call PythonProduct,PyphotonsAnalyzer,src/photons/Analyzer/python,src_photons_Analyzer_python))
else
$(eval $(call MultipleWarningMsg,PyphotonsAnalyzer,src/photons/Analyzer/python))
endif
ALL_COMMONRULES += src_photons_Analyzer_python
src_photons_Analyzer_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_photons_Analyzer_python,src/photons/Analyzer/python,PYTHON))
