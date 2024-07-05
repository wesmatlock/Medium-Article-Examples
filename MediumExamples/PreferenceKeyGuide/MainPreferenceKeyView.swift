import SwiftUI

struct MainPreferenceKeyView: View {
  var body: some View {
    ParentView()
  }
}

//struct ChildView: View {
//  var body: some View {
//    Text("Hello, SwiftUI!")
//      .background(
//        GeometryReader { geometry in
//          Color.clear
//            .preference(key: MyPreferenceKey.self, value: "\(geometry.size.width)")
//        }
//      )
//  }
//}
//
//struct ParentView: View {
//  @State private var width: String = ""
//
//  var body: some View {
//    VStack {
//      ChildView()
//      Text("Width: \(width)")
//    }
//    .onPreferenceChange(MyPreferenceKey.self) { value in
//      self.width = value
//    }
//  }
//}

struct TotalWidthKey: PreferenceKey {
  static var defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}

struct ChildView: View {
  var body: some View {
    Text("Child View")
      .padding()
      .background(GeometryReader { geometry in
        Color.clear.preference(key: TotalWidthKey.self, value: geometry.size.width)
      })
  }
}

struct ChildViewTwo: View {
  var body: some View {
    Text("Child View Two")
      .padding()
      .background(GeometryReader { geometry in
        Color.clear.preference(key: TotalWidthKey.self, value: geometry.size.width)
      })
  }
}

struct ChildViewThree: View {
  var body: some View {
    Text("Child View Three")
      .padding()
      .background(GeometryReader { geometry in
        Color.clear.preference(key: TotalWidthKey.self, value: geometry.size.width)
      })
  }
}

struct ParentView: View {
  @State private var totalWidth: CGFloat = 0

  var body: some View {
    VStack {
      ChildView()
      ChildViewTwo()
      ChildViewThree()
      Text("Total Width: \(totalWidth)")
    }
    .onPreferenceChange(TotalWidthKey.self) { value in
      self.totalWidth = value
    }
  }
}

#Preview {
  MainPreferenceKeyView()
}

