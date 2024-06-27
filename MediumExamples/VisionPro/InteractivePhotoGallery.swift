import SwiftUI
import Vision

#if os(visionOS)
struct InteractivePhotoGallery: View {
  @State private var photos = ["photo1", "photo2", "photo3"]
  @State private var currentIndex = 0
  @State private var scale: CGFloat = 1.0
  @State private var handPosition: CGPoint = .zero
  @State private var isLookingAtNextButton = false

  var body: some View {
    VStack {
      Image(photos[currentIndex])
        .resizable()
        .scaledToFit()
        .scaleEffect(scale)
        .gesture(
          MagnificationGesture()
            .onChanged { value in
              scale = value
            }
        )
        .gesture(
          DragGesture()
            .onEnded { value in
              if value.translation.width > 0 {
                currentIndex = (currentIndex - 1 + photos.count) % photos.count
              } else {
                currentIndex = (currentIndex + 1) % photos.count
              }
            }
        )
        .onTapGesture {
          scale = 1.0
        }

      HStack {
        Button(action: {
          currentIndex = (currentIndex - 1 + photos.count) % photos.count
        }) {
          Text("Previous")
        }
        .padding()
        .background(isLookingAtNextButton ? Color.red : Color.clear)
        .onAppear {
          startEyeTracking()
        }

        Button(action: {
          currentIndex = (currentIndex + 1) % photos.count
        }) {
          Text("Next")
        }
        .padding()
        .background(isLookingAtNextButton ? Color.red : Color.clear)
        .onAppear {
          startEyeTracking()
        }
      }
    }
    .onAppear {
      startHandTracking()
    }
  }

  func startHandTracking() {
    // Implementation for starting hand tracking
    // Update handPosition based on detected hand movements
  }

  func startEyeTracking() {
    // Implementation for starting eye tracking
    // Update isLookingAtNextButton based on detected gaze
  }
}

#Preview {
  InteractivePhotoGallery()
}

#endif

