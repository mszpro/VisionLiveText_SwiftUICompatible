//
//  File.swift
//
//
//  Created by Shunzhe Ma on 8/22/20.
//

/**
 <key>NSPhotoLibraryUsageDescription</key>
 <string>写真ライブラリへのアクセスが必要です</string>
 */

#if os(iOS) && !targetEnvironment(macCatalyst)

import Foundation
import UIKit
import SwiftUI
import MobileCoreServices

@available(iOS 13.0, *)
public struct ImagePicker: UIViewControllerRepresentable {

    var onImagePicked: (UIImage) -> Void
    var onCancelled: () -> Void
    
    public init(onImagePicked: @escaping (UIImage) -> Void, onCancelled: @escaping () -> Void) {
        self.onImagePicked = onImagePicked
        self.onCancelled = onCancelled
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        return
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        pickerController.mediaTypes = [kUTTypeImage as String]
        pickerController.sourceType = .photoLibrary
        return pickerController
    }

    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker

        init(_ vc: ImagePicker) {
            self.parent = vc
            super.init()
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            guard let image = info[.originalImage] as? UIImage else {
                self.parent.onCancelled()
                return
            }
            self.parent.onImagePicked(image)
        }

    }
}

#endif
