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
public struct ScanAndSelectTextView: View {
    
    @State private var scannedItem: RecognizedItem?
    @State private var showScanningView: Bool = false
    var showScanningViewButtonLabel: String
    var cancelScanningViewButtonLabel: String
    
    public init(showScanningViewButtonLabel: String = "Show scanning view",
                cancelScanningViewButtonLabel: String = "Cancel") {
        self.showScanningViewButtonLabel = showScanningViewButtonLabel
        self.cancelScanningViewButtonLabel = cancelScanningViewButtonLabel
    }
    
    public var body: some View {
        
        Group {
            
            // Button to start scanning
            Button(showScanningViewButtonLabel) {
                self.showScanningView = true
            }
            .sheet(isPresented: $showScanningView) {
                NavigationStack {
                    DataScannerView(startScanning: $showScanningView,
                                    tappedScanItem: $scannedItem)
                    .disabled(!(DataScannerViewController.isSupported && DataScannerViewController.isAvailable))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(cancelScanningViewButtonLabel) {
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
                        .textSelection(.enabled)
                case .barcode(let barcode):
                    Text(barcode.payloadStringValue ?? "")
                        .textSelection(.enabled)
                }
            }
            
        }
        
    }
    
}

#endif
