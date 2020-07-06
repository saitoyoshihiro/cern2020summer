#!/usr/bin/env python2

# Configuration file for Analyzer.cc

import FWCore.ParameterSet.Config as cms
from FWCore.ParameterSet.VarParsing import VarParsing
from Configuration.Eras.Era_Phase2C10_cff import Phase2C10


process = cms.Process('HFNoseAnalyzer',Phase2C10)

options = VarParsing ('analysis')
options.register ('pt', '1', VarParsing.multiplicity.singleton, VarParsing.varType.string,
                    "(type: string) pt value of the photon")
options.parseArguments()

process.load('FWCore.MessageService.MessageLogger_cfi')
# Important to load geometry configs because they are part of EventSetup
# Not sure why the following works
# process.load('Geometry.ForwardCommonData.hfnoseXML_cfi')
# process.load('Geometry.ForwardCommonData.hfnoseParametersInitialization_cfi')
# process.load('Geometry.ForwardCommonData.hfnoseNumberingInitialization_cfi')
# process.load('Geometry.CaloEventSetup.HFNoseTopology_cfi')
# process.load('Geometry.ForwardGeometry.HFNoseGeometryESProducer_cfi')
process.load('Configuration.Geometry.GeometryExtended2026D47Reco_cff')
process.load('Configuration.Geometry.GeometryExtended2026D47_cff')

process.load("Configuration.StandardSequences.FrontierConditions_GlobalTag_cff")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, 'auto:phase2_realistic_T15', '')


option = "displaced"

if option == "displaced":
    inputfile = 'file:/afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/src/photons/displaced/step3.root'
    outputfile = '/afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/src/photons/displaced/result.root'
else:
    inputfile = 'file:/afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/src/photons/stdmodel/step3.root'
    outputfile = '/afs/cern.ch/work/y/yosaito/public/2020summer/CMSSW_11_2_0_pre1_LLP/src/photons/stdmodel/result.root'

process.source = cms.Source('PoolSource',
    fileNames = cms.untracked.vstring(inputfile)
)

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(-1)
)

process.Analysis = cms.EDAnalyzer('Analyzer')

process.TFileService = cms.Service('TFileService',
    fileName = cms.string(outputfile)
)

process.Timing = cms.Service("Timing",
  summaryOnly = cms.untracked.bool(True),
  useJobReport = cms.untracked.bool(True)
)

process.p = cms.Path(process.Analysis)
