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
