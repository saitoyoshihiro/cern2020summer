ifeq ($(strip $(SimGeneralMixingModulePlugins)),)
SimGeneralMixingModulePlugins := self/src/SimGeneral/MixingModule/plugins
PLUGINS:=yes
SimGeneralMixingModulePlugins_files := $(patsubst src/SimGeneral/MixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/MixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/MixingModule/plugins/$(file). Please fix src/SimGeneral/MixingModule/plugins/BuildFile.))))
SimGeneralMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/plugins/BuildFile
SimGeneralMixingModulePlugins_LOC_USE := self  DataFormats/Common DataFormats/Provenance FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities FWCore/PluginManager Mixing/Base SimDataFormats/CaloHit SimDataFormats/CrossingFrame SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimGeneral/MixingModule clhep CondFormats/DataRecord CondFormats/RunInfo CondCore/DBOutputService DataFormats/TrackerRecHit2D
SimGeneralMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralMixingModulePlugins,SimGeneralMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/MixingModule/plugins))
SimGeneralMixingModulePlugins_PACKAGE := self/src/SimGeneral/MixingModule/plugins
ALL_PRODS += SimGeneralMixingModulePlugins
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModulePlugins
SimGeneralMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins,src_SimGeneral_MixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_plugins
src_SimGeneral_MixingModule_plugins_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_plugins,src/SimGeneral/MixingModule/plugins,PLUGINS))
ifeq ($(strip $(SimGeneral/MixingModule)),)
ALL_COMMONRULES += src_SimGeneral_MixingModule_src
src_SimGeneral_MixingModule_src_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_src,src/SimGeneral/MixingModule/src,LIBRARY))
SimGeneralMixingModule := self/SimGeneral/MixingModule
SimGeneral/MixingModule := SimGeneralMixingModule
SimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/BuildFile
SimGeneralMixingModule_LOC_USE := self  FWCore/Framework FWCore/PluginManager FWCore/ParameterSet
SimGeneralMixingModule_EX_LIB   := SimGeneralMixingModule
SimGeneralMixingModule_EX_USE   := $(foreach d,$(SimGeneralMixingModule_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/src
ALL_PRODS += SimGeneralMixingModule
SimGeneralMixingModule_CLASS := LIBRARY
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModule
SimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModule,src/SimGeneral/MixingModule/src,src_SimGeneral_MixingModule_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
