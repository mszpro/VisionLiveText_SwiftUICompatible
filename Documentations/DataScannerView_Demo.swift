//
//  DataScannerView_Demo.swift
//  NewInVisionKit_SwiftUI
//
//  Created by Shunzhe on 2022/06/16.
//

#if canImport(VisionKit)

import SwiftUI
import VisionKit

@available(iOS 16.0, *)
struct DataScannerView_Demo: View {
    
    @State private var scannedItem: RecognizedItem?
    @State private var showScanningView: Bool = false
    
    var body: some View {
        
        Form {
            
            // Button to start scanning
            Button("Show scanning view") {
                self.showScanningView = true
            }
            .sheet(isPresented: $showScanningView) {
                NavigationStack {
                    DataScannerView(startScanning: $showScanningView,
                                    tappedScanItem: $scannedItem)
                    .disabled(!(DataScannerViewController.isSupported && DataScannerViewController.isAvailable))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                self.showScanningView = false
                            }
                        }
                    }
                }
            }
            .onChange(of: scannedItem) { newValue in
                if newValue != nil {
                    self.showScanningView = false
                }
            }
            
            // Section to show tapped scan result
            if let scannedItem {
                switch scannedItem {
                case .text(let text):
                    Text(text.transcript)
                case .barcode(let barcode):
                    Text(barcode.payloadStringValue ?? "")
                }
            }
            
        }
        
    }
    
}

#endif
