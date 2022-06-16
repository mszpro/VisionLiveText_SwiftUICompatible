//
//  DataScannerView.swift
//  NewInVisionKit_SwiftUI
//
//  Created by Shunzhe on 2022/06/16.
//

#if canImport(VisionKit)

import SwiftUI
import VisionKit

@available(iOS 16.0, *)
public struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var startScanning: Bool
    @Binding var tappedScanItem: RecognizedItem?
    
    public init(startScanning: Binding<Bool>, tappedScanItem: Binding<RecognizedItem?>) {
        self._startScanning = startScanning
        self._tappedScanItem = tappedScanItem
    }
    
    public func makeUIViewController(context: Context) -> DataScannerViewController {
        let scannerVC = DataScannerViewController(
            recognizedDataTypes: [.text()],
                qualityLevel: .fast,
                recognizesMultipleItems: false,
                isHighFrameRateTrackingEnabled: false,
                isGuidanceEnabled: true,
                isHighlightingEnabled: true
        )
        scannerVC.delegate = context.coordinator
        return scannerVC
    }
    
    public func updateUIViewController(_ viewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? viewController.startScanning()
        } else {
            viewController.stopScanning()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        var parent: DataScannerView
        
        init(_ parent: DataScannerView) {
            self.parent = parent
        }
        
        public func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            parent.tappedScanItem = item
        }
        
    }
    
}

@available(iOS 16.0, *)
extension RecognizedItem: Equatable {
    public static func == (lhs: RecognizedItem, rhs: RecognizedItem) -> Bool {
        return lhs.id == rhs.id
    }
}

#endif
