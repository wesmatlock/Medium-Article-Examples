import SwiftUI

struct CameraScanView: View {
  @State private var recognizedText = "Point your camera at text to scan"
  var body: some View {
    VStack {
      Text("Text Scanner")
        .font(.title)
        .padding()
      Text(recognizedText)
        .padding()
        .border(Color.gray, width: 1)
      CameraView(recognizedText: $recognizedText)
        .edgesIgnoringSafeArea(.all)
    }
  }
}

#Preview {
  CameraScanView()
}
