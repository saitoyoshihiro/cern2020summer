#include <iostream>
#include <array>

#include <cmath> // Switch to TMath.h if you need more physics-related functions
#include "DataFormats/Math/interface/deltaR.h"

#include "FWCore/Framework/interface/Frameworkfwd.h"
#include "FWCore/Framework/interface/Event.h"
#include "FWCore/Framework/interface/EventSetup.h"
#include "FWCore/ServiceRegistry/interface/Service.h"
#include "CommonTools/UtilAlgos/interface/TFileService.h"
#include "FWCore/Framework/interface/MakerMacros.h"

#include "FWCore/MessageLogger/interface/MessageLogger.h"

// Physics objects
#include "DataFormats/CaloRecHit/interface/CaloCluster.h"
#include "DataFormats/HepMCCandidate/interface/GenParticle.h"

// HFNose (forward + HGCal)
#include "DataFormats/ForwardDetId/interface/HFNoseDetId.h"

// HF (forward + HCal)
// #include "DataFormats/HCalRecHit/interface/HCalRecHitCollections.h"
// #include "DataFormats/HCalDetId/interface/HCalDetId.h"

// CMS Coordinate System
#include "DataFormats/GeometryVector/interface/GlobalPoint.h"

// Detector Geometry
#include "Geometry/HGCalGeometry/interface/HGCalGeometry.h"
#include "Geometry/Records/interface/IdealGeometryRecord.h"
#include "Geometry/CaloGeometry/interface/CaloGeometry.h"
#include "Geometry/CaloGeometry/interface/CaloSubdetectorGeometry.h"

// ROOT headers
#include <TTree.h>

// From header files
#include <map>
#include <string>
#include <vector>

/* #include "FWCore/Framework/interface/EDAnalyzer.h" */
#include "FWCore/Framework/interface/one/EDAnalyzer.h"
#include "FWCore/ParameterSet/interface/ParameterSet.h"

#include "DataFormats/Math/interface/LorentzVector.h"
#include "DataFormats/HGCRecHit/interface/HGCRecHitCollections.h"


using namespace edm;

// Forward declarations
class TH1F;

class HGCalGeometry;

namespace reco
{
    class GenParticle;
    typedef std::vector<GenParticle> GenParticleCollection;
    class CaloCluster;
}

class Analyzer : public edm::one::EDAnalyzer<edm::one::SharedResources>
{

  public:
    explicit Analyzer ( const edm::ParameterSet& );
    ~Analyzer ();
    struct ClusterFields {
        unsigned run = 0;
        unsigned id = 0;
        int ieta = 0;
        int iphi = 0;
        std::vector<double> energy;
        std::vector<int> layers;
    };

  private:
    virtual void beginJob () override;
    virtual void analyze ( const edm::Event&, const edm::EventSetup& );
    virtual void endJob () override;
  
    std::vector<math::XYZTLorentzVectorF> getTruthP4 ( const reco::GenParticleCollection & );
    
    // ------ Data members -------
    TTree* tree;
    
    // Input Tags
    edm::InputTag tag_HGCHFNoseRecHits_;
    edm::InputTag tag_HGCalLayerClustersHFNose_;
    edm::InputTag tag_GenParticle_;
    
    // Others
    Int_t   select_PID_;
    Float_t select_EtaLow_;
    Float_t select_EtaHigh_;
    Float_t select_coneR_;

    // Tokens
    edm::EDGetTokenT<HGCRecHitCollection> token_HGCRecHits_;
    edm::EDGetTokenT<std::vector<reco::CaloCluster>> token_HGCalLayerClustersHFNose_;
    edm::EDGetTokenT<reco::GenParticleCollection> token_GenParticle_;

    edm::Service<TFileService> fs;
    ClusterFields entry;
    std::unordered_map<unsigned,ClusterFields> treemap;
};

Analyzer::Analyzer ( const edm::ParameterSet& iConfig ) :
    tree(NULL),

    // (tag name, default value (label, instance, process) -- CHECK SPELLING!!!!!!!
    tag_HGCHFNoseRecHits_ ( iConfig.getUntrackedParameter<edm::InputTag> ("TAG_HGCHFNoseRecHits", edm::InputTag ("HGCalRecHit", "HGCHFNoseRecHits") ) ),
    tag_HGCalLayerClustersHFNose_ ( iConfig.getUntrackedParameter<edm::InputTag> ("TAG_HGCalLayerClusterHFNose", edm::InputTag ("hgcalLayerClustersHFNose") ) ),
    tag_GenParticle_ ( iConfig.getUntrackedParameter<edm::InputTag> ("TAG_GenParticle", edm::InputTag ("genParticles") ) ),

    // Pre-selection parameters
    select_PID_ ( 22 ),
    select_EtaLow_ ( 3.49 ),
    select_EtaHigh_ ( 3.51 ),
    select_coneR_ ( 0.5 )

{
    // consumes: frequent request of additional data | mayConsume: infrequent
    token_HGCRecHits_ = consumes<HGCRecHitCollection> ( tag_HGCHFNoseRecHits_ );
    token_HGCalLayerClustersHFNose_ = consumes<std::vector<reco::CaloCluster>> ( tag_HGCalLayerClustersHFNose_ );
    token_GenParticle_ = consumes<reco::GenParticleCollection> ( tag_GenParticle_ );

    // We will be making plots from these collections
    /* recoNoseClusterTag_ = consumes<std::vector<reco::CaloCluster>>(edm::InputTag("hgcalLayerClustersHFNose")); */
    /* simClusterTag_ = mayConsume<std::vector<SimCluster>>(edm::InputTag("mix","MergedCaloTruth")); */
    /* caloParticleTag_ = mayConsume<std::vector<CaloParticle>>(edm::InputTag("mix","MergedCaloTruth")); */
}


Analyzer::~Analyzer ()
{
    // Deconstructor
}

void Analyzer::beginJob ()
{
    edm::Service<TFileService> fs;

    tree = fs->make<TTree>("tree", "tree");
    tree->Branch("run"                   , &entry.run                   , "run/i");
    tree->Branch("ieta"                  , &entry.ieta                  , "ieta/F");
    tree->Branch("iphi"                  , &entry.iphi                  , "iphi/F");
    tree->Branch("energy"                , "vector<double>"             , &entry.energy, 32000, 0);
    tree->Branch("layers"                , "vector<int>"                , &entry.layers, 32000,0); //1 is by default, 0 means 'the object is serialized in the branch buffer'
}

void Analyzer::endJob ()
{
    std::cout << "Analyzer ran successfully." << std::endl;
}

/* Method called on each new event */
void Analyzer::analyze ( const edm::Event& iEvent, const edm::EventSetup& iSetup )
{
    treemap.clear();

    // Event information
    edm::EventAuxiliary aux = iEvent.eventAuxiliary();
    unsigned run = aux.run();

    // Get Geometry
    edm::ESHandle<HGCalGeometry> handle_HGCalGeometry;
    iSetup.get<IdealGeometryRecord>().get( "HGCalHFNoseSensitive", handle_HGCalGeometry );


    // Get Layer Clusters
    edm::Handle<std::vector<reco::CaloCluster>> handle_HGCalLayerClustersHFNose;
    iEvent.getByToken ( token_HGCalLayerClustersHFNose_, handle_HGCalLayerClustersHFNose ); 

    // Loop over LayerClustersHFNose
    for (const auto& cl : *(handle_HGCalLayerClustersHFNose.product())){
        HFNoseDetId hfnoseId = HFNoseDetId( cl.hitsAndFractions().at(0).first );
        ClusterFields& ntup = treemap[hfnoseId.rawId()];
        //check for existence of entry
        if(ntup.id==0){
            ntup.ieta = cl.eta();
            ntup.iphi = cl.phi();
            ntup.layers.push_back(hfnoseId.layer());
        }
    }

    // Get hits
    edm::Handle<HGCRecHitCollection> handle_HGCRecHits;
    iEvent.getByToken ( token_HGCRecHits_, handle_HGCRecHits );
    // do nothing with hits for now
    

    // One tree entry per map entry
    entry.run = run;
    for (const auto& ntup : treemap){
        entry.ieta = ntup.second.ieta;
        entry.iphi = ntup.second.iphi;
        entry.energy = ntup.second.energy;
        entry.layers = ntup.second.layers;
        tree->Fill();
    }

    // Get gen particles
    edm::Handle<reco::GenParticleCollection> handle_GenParticle;
    iEvent.getByToken ( token_GenParticle_, handle_GenParticle );
}


std::vector<math::XYZTLorentzVectorF> Analyzer::getTruthP4 ( const reco::GenParticleCollection & GenParticles )
{
    std::vector<math::XYZTLorentzVectorF> container;

    for ( auto const& gen: GenParticles )
    {
        if ( gen.pdgId() == select_PID_
                && abs(gen.eta()) > select_EtaLow_
                && abs(gen.eta()) < select_EtaHigh_  )
        {
            container.push_back ( (math::XYZTLorentzVectorF) gen.p4() );
        }
    }

    return container;
}





// Define this as a plugin
DEFINE_FWK_MODULE (Analyzer);
