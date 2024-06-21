import SwiftUI

struct MainPresentationDetent: View {
  @State private var showSheet = false

  var body: some View {
    VStack {
      Button("Show Sheet") {
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        DynamicContentSheetView()
//        SheetView()
//          .presentationDetents([.medium, .large])
          .presentationDetents([.medium, .large, .fraction(0.25), .height(200)])
      }
    }
  }
}

struct SheetView: View {
  var body: some View {
    VStack {
      Text("This is a sheet view")
      // Add more content here
    }
    .padding()
  }
}

#Preview {
  MainPresentationDetent()
}
