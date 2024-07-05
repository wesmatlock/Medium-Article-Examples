
import SwiftUI

struct SyncronizedView: View {
  var body: some View {
    CoordinatedParentView()
  }
}

struct SynchronizedSizeKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = CGSize(width: max(value.width, nextValue().width), height: max(value.height, nextValue().height))
  }
}

struct SynchronizedView: View {
  var body: some View {
    Text("Synchronized View")
      .padding()
      .background(GeometryReader { geometry in
        Color.clear.preference(key: SynchronizedSizeKey.self, value: geometry.size)
      })
  }
}

struct SynchronizedViewTwo: View {
  var body: some View {
    Text("Synchronized View Two")
      .padding()
      .background(GeometryReader { geometry in
        Color.clear.preference(key: SynchronizedSizeKey.self, value: geometry.size)
      })
  }
}

struct CoordinatedParentView: View {
  @State private var synchronizedSize: CGSize = .zero

  var body: some View {
    VStack {
      SynchronizedView()
      SynchronizedViewTwo()
      Text("Size: \(synchronizedSize.width) x \(synchronizedSize.height)")
    }
    .onPreferenceChange(SynchronizedSizeKey.self) { value in
      self.synchronizedSize = value
    }
  }
}

#Preview {
  SyncronizedView()
}
