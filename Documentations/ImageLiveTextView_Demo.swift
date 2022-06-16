//
//  ImageLiveTextView_Demo.swift
//  NewInVisionKit_SwiftUI
//
//  Created by Shunzhe on 2022/06/16.
//

import SwiftUI

#if canImport(SwiftUICompatible)
import SwiftUICompatible // Swift Package `https://github.com/mszmagic/SwiftUICompatible.git`

@available(iOS 16.0, *)
struct ImageLiveTextView_Demo: View {
    
    @State private var pickedImageObject: UIImage?
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        
        Form {
            
            Button("Pick a photo") {
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

struct ImageLiveTextView_Demo_Previews: PreviewProvider {
    static var previews: some View {
        ImageLiveTextView_Demo()
    }
}

#endif
