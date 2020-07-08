ifeq ($(strip $(photonsAnalyzerAuto)),)
photonsAnalyzerAuto := self/src/photons/Analyzer/plugins
PLUGINS:=yes
photonsAnalyzerAuto_files := $(patsubst src/photons/Analyzer/plugins/%,%,$(wildcard $(foreach dir,src/photons/Analyzer/plugins ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
photonsAnalyzerAuto_BuildFile    := $(WORKINGDIR)/cache/bf/src/photons/Analyzer/plugins/BuildFile
photonsAnalyzerAuto_LOC_USE := self  FWCore/Framework FWCore/PluginManager FWCore/ParameterSet FWCore/ServiceRegistry CommonTools/UtilAlgos DataFormats/HGCRecHit DataFormats/ForwardDetId DataFormats/HepMCCandidate DataFormats/CaloRecHit DataFormats/GeometryVector SimDataFormats/CaloHit Geometry/Records Geometry/HGCalGeometry Geometry/CaloGeometry
photonsAnalyzerAuto_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,photonsAnalyzerAuto,photonsAnalyzerAuto,$(SCRAMSTORENAME_LIB),src/photons/Analyzer/plugins))
photonsAnalyzerAuto_PACKAGE := self/src/photons/Analyzer/plugins
ALL_PRODS += photonsAnalyzerAuto
photons/Analyzer_forbigobj+=photonsAnalyzerAuto
photonsAnalyzerAuto_INIT_FUNC        += $$(eval $$(call Library,photonsAnalyzerAuto,src/photons/Analyzer/plugins,src_photons_Analyzer_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
photonsAnalyzerAuto_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,photonsAnalyzerAuto,src/photons/Analyzer/plugins))
endif
ALL_COMMONRULES += src_photons_Analyzer_plugins
src_photons_Analyzer_plugins_parent := photons/Analyzer
src_photons_Analyzer_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_photons_Analyzer_plugins,src/photons/Analyzer/plugins,PLUGINS))
