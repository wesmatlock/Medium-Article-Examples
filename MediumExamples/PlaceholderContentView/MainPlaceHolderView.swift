import SwiftUI

struct MainPlaceHolderView: View {
  @State private var isLoading = true
  var body: some View {
    Group {
      if isLoading {
        MyPLaceholderView()
        AnimatedPlaceHolderView()
        TransitionExampleView()
      } else {
        Text("Content Loaded")
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        isLoading = false
      }
    }
  }
}

// MARK: - PlaceholderView
struct MyPLaceholderView: View {
  var body: some View {
    VStack {
      ForEach(0..<3) { _ in
        HStack {
          Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 50, height: 50)
          VStack {
            Rectangle()
              .fill(Color.gray.opacity(0.3))
              .frame(height: 20)
            Rectangle()
              .fill(Color.gray.opacity(0.3))
              .frame(height: 20)
              .padding(.top, 10)
          }
          .padding(.leading, 10)
        }
        .padding()
      }
    }
  }
}

// MARK: - Animation Placeholder View
struct AnimatedPlaceHolderView: View {
  @State private var animate = false

  var body: some View {
    VStack {
      ForEach(0..<3) { _ in
        HStack {
          Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 50, height: 50)
            .scaleEffect(animate ? 1.1 : 1.0)

          VStack {
            Rectangle()
              .fill(Color.gray.opacity(0.3))
              .frame(height: 20)
              .scaleEffect(animate ? 1.1 : 1.0)

            Rectangle()
              .fill(Color.gray.opacity(0.3))
              .frame(height: 20)
              .padding(.top, 10)
              .scaleEffect(animate ? 1.1 : 1.0)

          }
          .padding(.leading, 10)
        }
        .padding()
      }
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
        animate.toggle()
      }
    }
  }
}

// MARK: - Transition View
struct TransitionExampleView: View {
  @State private var showDetail = false

  var body: some View {
    VStack {
      if showDetail {
        Text("Detailed View")
          .padding()
          .background(Color.blue)
          .cornerRadius(10)
          .transition(.asymmetric(insertion: .slide, removal: .scale))
      }

      Button("Toggle View") {
        withAnimation {
          showDetail.toggle()
        }
      }
    }
  }
}

#Preview {
  MainPlaceHolderView()
}
