//
//  File.swift
//
//
//  Created by Shunzhe Ma on 8/15/20.
//

#if os(iOS) && !targetEnvironment(macCatalyst)

import Foundation
import SwiftUI
import PhotosUI

/**
 # Example #
 ユーザーが1つの画像を選択できるようにするには
 ```
 PhotoPickerView(onImagePicked: { (image) in
     print(image)
 })
 ```
 ユーザーが複数の画像を選択できるようにするには
 ```
 PhotoPickerView(onImagePicked: { (image) in
     print(image)
 }, selectionLimit: 2)
 ```
 動画のみを表示するには
 ```
 PhotoPickerView(onImagePicked: { (image) in
     print(image)
 }, filter: .videos)
 ```
 */

@available(iOS 14.0, *)
public struct PhotoPickerView: UIViewControllerRepresentable {

    private let onImagePicked: (UIImage) -> Void
    private var filter: PHPickerFilter? = nil
    private var selectionLimit: Int = 1
    @Environment(\.presentationMode) private var presentationMode

    public init(onImagePicked: @escaping (UIImage) -> Void, selectionLimit: Int = 1, filter: PHPickerFilter? = nil) {
        self.onImagePicked = onImagePicked
        self.filter = filter
        self.selectionLimit = selectionLimit
    }

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let photoLibrary = PHPhotoLibrary.shared()
        var config = PHPickerConfiguration(photoLibrary: photoLibrary)
        config.filter = self.filter
        config.selectionLimit = self.selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: self.onImagePicked)
    }

    final public class Coordinator: NSObject, PHPickerViewControllerDelegate {

        private let onImagePicked: (UIImage) -> Void
        
        public init(onImagePicked: @escaping (UIImage) -> Void) {
            self.onImagePicked = onImagePicked
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            for result in results {
                // Check if we can load the objects
                result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    guard error == nil,
                          let imageObject = image as? UIImage
                          else {
                        print(error?.localizedDescription ?? "Unknown error")
                        return
                    }
                    self.onImagePicked(imageObject)
                }
            }
        }

    }

}

#endif
