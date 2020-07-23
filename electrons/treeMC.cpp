/*
 * June 9, 2020
 * MIT
 * Yoshihiro Saito
 * 2020 Summer UROP
 *
 * Usage
 *
 * If you want to run from root: 
 * root treeMC.C
 * 
 * If you want to compile then run as C++:
 * g++ -o treeMC treeMC.C `root-config --cflags --libs`
 * then run
 * ./treeMC.C
 * (if you don't want histograms to popup run: ./treeMC.C -b)
 *
 * all histograms will then be saved in "beaut" directory under the current directory
 */

#include "TCanvas.h"
#include "TROOT.h"
#include "TH1F.h"
#include "TFile.h"
#include "TTree.h"
#include "TApplication.h"
#include "TImage.h"
#include <iostream>
#include "TSystem.h"
#include "TStyle.h"
#include "TLegend.h"

void prettify1d(std::vector<TH1F*> histograms){
    for (TH1F *hist : histograms){
        TCanvas *c = new TCanvas();
        hist->Draw("hist");
        c->Print((TString)hist->GetName()+".eps", "eps");
    }
}

void treeMC() {
    TFile *top = new TFile("stdmodel_result.root");
    TDirectory *d = (TDirectory*)top->Get("Analysis");
    TTree *t1 = (TTree*)d->Get("tree");

    std::vector<TH1F*> histograms;
    TH1F *layerHist = new TH1F("layer", "Layer", 8, 1, 9);
    TH1F *etaHist = new TH1F("eta", "Eta", 100, -5, 5);
    TH1F *phiHist = new TH1F("phi", "Phi", 100, -3.15, 3.15);


    Float_t eta;
    Float_t phi;
    std::vector<int> *layer;

    t1->SetBranchAddress("eta", &eta);
    t1->SetBranchAddress("layers", &layer);
    t1->SetBranchAddress("phi", &phi);

    Int_t nentries = (Int_t) t1->GetEntries();

    for (Int_t i = 0; i < nentries; i++) {

        t1->GetEntry(i);

        etaHist->Fill(eta);
        phiHist->Fill(phi);

        for (int l : *layer){
            layerHist->Fill(l);
        }

    }

    histograms.push_back(etaHist);
    histograms.push_back(layerHist);
    histograms.push_back(phiHist);

    prettify1d(histograms);

    //etaHist->Draw("hist");
    //layerHist->Draw("hist");

}



void helper(int argc, char** argv) {
    treeMC();
}

int main(int argc, char** argv) {
    TApplication app("ROOT Application", &argc, argv);
    helper(app.Argc(), app.Argv());
    app.Run();
    return 0;
}
