import AVFoundation
import UIKit
import SwiftUI
import Vision

final class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
  var session: AVCaptureSession?
  @Binding var recognizedText: String

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCamera()
    setupVision()
  }

  private func setupCamera() {
    session = AVCaptureSession()
    guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
    guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
    session?.addInput(input)
    session?.startRunning()
    let output = AVCaptureVideoDataOutput()
    output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    session?.addOutput(output)

    let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
    previewLayer.frame = view.bounds
    view.layer.addSublayer(previewLayer)
  }

  private func setupVision() {
    let textRecognitionRequest = VNRecognizeTextRequest { [weak self] (request, error) in
      if let observations = request.results as? [VNRecognizedTextObservation] {
        let text = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: ", ")
        DispatchQueue.main.async {
          self?.recognizedText = text
        }
      }
    }
    textRecognitionRequest.recognitionLevel = .accurate
    textRecognitionRequest.usesLanguageCorrection = true
  }

}
