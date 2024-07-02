import SwiftUI

struct MainProgresView: View {
  var body: some View {
    VStack {
//      BasicProgressView()
//      CustomProgressView()
//      AnimatedProgressView()
//      AsyncTaskProgressView()
//      ListProgressView()
//      AccessibleProgressView()
    }
  }
}

// MARK: - Basic
struct BasicProgressView: View {
  @State private var progress: Double = 0.5

  var body: some View {
    ProgressView(value: progress)
      .progressViewStyle(LinearProgressViewStyle())
      .padding()
  }
}

// MARK: - Custom Circlular
struct CustomCircularProgressViewStyle: ProgressViewStyle {
  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      Circle()
        .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
        .stroke(Color.blue, lineWidth: 10)
        .rotationEffect(.degrees(-90))
        .animation(.linear, value: configuration.fractionCompleted)
      Text(String(format: "%.0f%%", (configuration.fractionCompleted ?? 0) * 100))
        .font(.largeTitle)
        .bold()
    }
  }
}

struct CustomProgressView: View {
  @State private var progress: Double = 0.75

  var body: some View {
    ProgressView(value: progress)
      .progressViewStyle(CustomCircularProgressViewStyle())
      .frame(width: 100, height: 100)
      .padding()
  }
}

// MARK: - Animation Progress
struct AnimatedProgressView: View {
  @State private var progress: Double = 0.0

  var body: some View {
    ProgressView(value: progress)
      .progressViewStyle(LinearProgressViewStyle())
      .padding()
      .onAppear {
        withAnimation(.easeInOut(duration: 2.0)) {
          progress = 1.0
        }
      }
  }
}

// MARK: - List Progress
struct ListProgressView: View {
  @State private var items = Array(repeating: 0.0, count: 10)

  var body: some View {
    List(0..<10) { index in
      HStack {
        Text("Item \(index + 1)")
        ProgressView(value: items[index])
          .progressViewStyle(LinearProgressViewStyle())
      }
    }
    .onAppear {
      for i in items.indices {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
          items[i] = 1.0
        }
      }
    }
  }
}

// MARK: - AsyncTask
struct AsyncTaskProgressView: View {
  @State private var progress: Double = 0.0

  var body: some View {
    VStack {
      ProgressView(value: progress)
        .progressViewStyle(LinearProgressViewStyle())
        .padding()

      Button("Start Task") {
        Task {
          await startAsyncTask()
        }
      }
    }
  }

  func startAsyncTask() async {
    for i in 0...10 {
      try? await Task.sleep(nanoseconds: 500_000_000) // Sleep for 0.5 seconds
      progress = Double(i) / 10.0
    }
  }
}

// MARK: - Accessible
struct AccessibleProgressView: View {
  @State private var progress: Double = 0.5

  var body: some View {
    ProgressView("Loading...", value: progress)
      .progressViewStyle(CircularProgressViewStyle())
      .accessibilityLabel(Text("Loading progress"))
      .accessibilityValue(Text("\(Int(progress * 100)) percent completed"))
      .padding()
  }
}

#Preview {
  MainProgresView()
}
