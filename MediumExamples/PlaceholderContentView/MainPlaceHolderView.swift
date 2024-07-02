import SwiftUI

struct MainPlaceHolderView: View {
  @State private var isLoading = true
  var body: some View {
    Group {
      if isLoading {
        //        MyPLaceholderView()
        //        AnimatedPlaceHolderView()
        //        TransitionExampleView()
        //        AnimatedPlaceholderView()
//        ShimmerView()
                ThemedPlaceholderView()
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
            .fill(Color.gray.opacity(0.5))
            .frame(width: 50, height: 50)
          VStack {
            Rectangle()
              .fill(Color.gray.opacity(0.5))
              .frame(height: 20)
            Rectangle()
              .fill(Color.gray.opacity(0.5))
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

struct ShimmerView: View {
  @State private var shimmer = false

  var body: some View {
    VStack {
      ForEach(0..<3) { _ in
        HStack {
          Circle()
            .fill(Color.green.opacity(0.3))
            .frame(width: 50, height: 50)
            .modifier(ShimmerEffect())
          VStack(alignment: .leading) {
            Rectangle()
              .fill(Color.green.opacity(0.3))
              .frame(height: 20)
              .modifier(ShimmerEffect())
            Rectangle()
              .fill(Color.green.opacity(0.3))
              .frame(height: 20)
              .padding(.top, 5)
              .modifier(ShimmerEffect())
          }
          .padding(.leading, 10)
        }
        .padding()
      }
    }
  }
}

struct ShimmerEffect: ViewModifier {
  @State private var startPoint = UnitPoint(x: -1, y: 0.5)
  @State private var endPoint = UnitPoint(x: 1, y: 0.5)

  func body(content: Content) -> some View {
    content
      .overlay(
        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.1), Color.white.opacity(0.5)]), startPoint: startPoint, endPoint: endPoint)
          .blendMode(.overlay)
          .mask(content)
      )
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
          startPoint = UnitPoint(x: 1, y: 0.5)
          endPoint = UnitPoint(x: -1, y: 0.5)
        }
      }
  }
}

struct ThemedPlaceholderView: View {
  var body: some View {
    VStack {
      ForEach(0..<3) { _ in
        HStack {
          Circle()
            .fill(Color.blue.opacity(0.3))
            .frame(width: 50, height: 50)
          VStack(alignment: .leading) {
            Rectangle()
              .fill(Color.blue.opacity(0.3))
              .frame(height: 20)
            Rectangle()
              .fill(Color.blue.opacity(0.3))
              .frame(height: 20)
              .padding(.top, 5)
          }
          .padding(.leading, 10)
        }
        .padding()
      }
    }
  }
}

#Preview {
  MainPlaceHolderView()
}
