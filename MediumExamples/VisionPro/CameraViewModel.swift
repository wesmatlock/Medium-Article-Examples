//import SwiftUI
//import Vision
//import AVFoundation
//
//#if os(visionOS)
//class CameraViewModel: ObservableObject {
//  private var captureSession: AVCaptureSession?
//  @Published var currentFrame: CGImage?
//
//  init() {
//    setupCamera()
//  }
//
//  private func setupCamera() {
//    captureSession = AVCaptureSession()
//    captureSession?.sessionPreset = .high // Use an available preset for VisionOS
//
//    guard let captureSession = captureSession,
//          let backCamera = AVCaptureDevice.default(for: .video),
//          let input = try? AVCaptureDeviceInput(device: backCamera)
//    else {
//      return
//    }
//
//    captureSession.addInput(input)
//
//    let videoOutput = AVCaptureVideoDataOutput()
//    videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
//    captureSession.addOutput(videoOutput)
//
//    captureSession.startRunning()
//  }
//}
//
//extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
//  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//    let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//    let context = CIContext()
//    guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
//
//    DispatchQueue.main.async {
//      self.currentFrame = cgImage
//    }
//  }
//}
//#endif
