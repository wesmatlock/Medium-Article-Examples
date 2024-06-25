import SwiftUI


struct HeaderHeightKey: PreferenceKey {
  static var defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}

struct DynamicHeaderView: View {
  @State private var headerHeight: CGFloat = 0

  var body: some View {
    VStack {
      Text("Dynamic Header")
        .font(.largeTitle)
        .frame(height: headerHeight)
        .background(Color.blue)

      ScrollView {
        VStack {
          ForEach(0..<50) { index in
            Text("Item \(index)")
              .padding()
              .background(GeometryReader { geometry in
                Color.clear.preference(key: HeaderHeightKey.self, value: geometry.frame(in: .global).maxY)
              })
          }
        }
      }
    }
    .onPreferenceChange(HeaderHeightKey.self) { value in
      self.headerHeight = value
    }
  }
}

#Preview {
    DynamicHeaderView()
}
