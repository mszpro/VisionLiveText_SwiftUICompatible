//
//  ImageLiveTextView_Demo.swift
//  NewInVisionKit_SwiftUI
//
//  Created by Shunzhe on 2022/06/16.
//

import SwiftUI

@available(iOS 16.0, *)
public struct PickImageAndShowLiveText: View {
    
    @State private var pickedImageObject: UIImage?
    @State private var showImagePicker: Bool = false
    var photoPickingButtonLabel: String
    
    public init(photoPickingButtonLabel: String = "Pick a photo") {
        self.photoPickingButtonLabel = photoPickingButtonLabel
    }
    
    public var body: some View {
        
        VStack {
            
            Button(photoPickingButtonLabel) {
                self.showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker { pickedImg in
                    self.pickedImageObject = pickedImg
                    self.showImagePicker = false
                } onCancelled: {
                    self.showImagePicker = false
                }
            }
            
            if let pickedImageObject {
                ImageLiveTextView(imageObject: pickedImageObject, analyzerConfiguration: .init(.text))
                    .frame(height: 500)
            }

            
        }
        
    }
    
}
