# Live Text - 画像テキスト認識 - SwiftUI互換ビュー

| DataScannerView | ImageLiveTextView |
|---|---|
| ![bar-code-scan-demo](/Documentations/livetext_barcode.jpg) | ![live-text-from-image-demo](/Documentations/livetext_imagescan.jpg) |

WWDC 2022 / iOS 16で公開された新機能「ライブテキスト」のSwiftUIで使用されている互換ビューです。
These are compatible views used in SwiftUI for the new live text feature released in WWDC 2022 / iOS 16.

## DataScannerView

You can use the `DataScannerView` to use a live camera stream and scan for text or machine-readable codes. Found elements will be highlighted and selectable. (remember to add the permission to access the camera)

You will present this view with camera view.

`DataScannerView`を使用すると、ライブカメラストリームを使用して、テキストまたは機械可読コードをスキャンすることができます。見つかった要素はハイライト表示され、選択することができます。(カメラへのアクセス権を追加することを忘れないでください)

カメラビューで表示されます。

```swift
// Button to start scanning
Button("Show scanning view") {
    self.showScanningView = true
}
.sheet(isPresented: $showScanningView) {
    NavigationStack {
        DataScannerView(startScanning: $showScanningView,
                        tappedScanItem: $scannedItem)
    }
}
```

You can check for device compatibility and disable the button when the device does not support this feature: `.disabled(!(DataScannerViewController.isSupported && DataScannerViewController.isAvailable))`

You may also need to add a button to close the scanner view:

デバイスの互換性をチェックして、デバイスがこの機能をサポートしていない場合はボタンを無効にすることができます： `.disabled(!(DataScannerViewController.isSupported && DataScannerViewController.isAvailable))`

また、スキャナビューを閉じるためのボタンを追加する必要があるかもしれません。

```swift
    .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                self.showScanningView = false
            }
        }
    }
```

[デモコードファイル](/Documentations/DataScannerView_Demo.swift)をご覧ください。

## ImageLiveTextView

You can also use the `ImageLiveTextView` to analyze an UIImage file. Users will be able to long-press to select the text recognized.
また、`ImageLiveTextView`を使用して`UIImage`ファイルを解析することができます。ユーザーは長押しで認識されたテキストを選択できるようになります。

```swift
if let pickedImageObject {
    ImageLiveTextView(imageObject: pickedImageObject, analyzerConfiguration: .init(.text))
        .frame(height: 500)
}
```

Here, `pickedImageObject` will contain the `UIImage` object the user picked.
ここで、 `pickedImageObject` にはユーザがピックした `UIImage` オブジェクトが入ります。

Remember to define a frame for the view.
ビューのフレームを定義することを忘れないでください。

[デモコードファイル](/Documentations/ImageLiveTextView_Demo.swift)をご覧ください。

## 使用方法

### Swift Package Manager

1. Xcode内からプロジェクトを開く
2. 上部のシステムバーの"File"をクリック
3. "Add Packages..."をクリック
4. 以下のURLをペースト：`https://github.com/mszpro/VisionLiveText_SwiftUICompatible.git`
5. Version: Up to Next Major `1.0 <`
6. "Next"をクリック
7. "Done"をクリック。

## LICENSE

MIT LICENSE. You have to include the complete and unmodified contents within the `LICENSE` file of this project and make it visible to the end user.
