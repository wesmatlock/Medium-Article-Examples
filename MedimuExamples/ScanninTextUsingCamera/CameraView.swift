import AVFoundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
  @Binding var recognizedText: String

  func makeUIViewController(context: Context) -> some CameraViewController {
    let controller = CameraViewController()
    controller.recognizedText = $recognizedText
    return controller
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
