//
//  ImageLiveTextView.swift
//  NewInVisionKit_SwiftUI
//
//  Created by Shunzhe on 2022/06/16.
//

import UIKit
import SwiftUI
import VisionKit

@available(iOS 16.0, *)
@MainActor
public struct ImageLiveTextView: UIViewRepresentable {
    
    var imageObject: UIImage
    var analyzerConfiguration: ImageAnalyzer.Configuration
    
    // Some configurations
    var allowLongPressForDataDetectorsInTextMode: Bool
    var selectableItemsHighlighted: Bool
    
    private let imageView = LiveTextUIImageView()
    private let analyzer = ImageAnalyzer()
    private let interaction = ImageAnalysisInteraction()
    
    public init(imageObject: UIImage, analyzerConfiguration: ImageAnalyzer.Configuration, allowLongPressForDataDetectorsInTextMode: Bool = false, selectableItemsHighlighted: Bool = false) {
        self.imageObject = imageObject
        self.analyzerConfiguration = analyzerConfiguration
        self.allowLongPressForDataDetectorsInTextMode = allowLongPressForDataDetectorsInTextMode
        self.selectableItemsHighlighted = selectableItemsHighlighted
    }
    
    public func makeUIView(context: Context) -> UIImageView {
        imageView.image = imageObject
        imageView.addInteraction(interaction)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    public func updateUIView(_ uiView: UIImageView, context: Context) {
        Task {
            if let image = imageView.image {
                let analysis = try? await analyzer.analyze(image, configuration: analyzerConfiguration)
                if let analysis = analysis {
                    interaction.analysis = analysis
                    interaction.preferredInteractionTypes = .textSelection
                    interaction.selectableItemsHighlighted = true
                    interaction.allowLongPressForDataDetectorsInTextMode = true
                }
            }
        }
        
    }
    
}

class LiveTextUIImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        .zero
    }
}
