import SwiftUI

struct CustomDetentView: View {
  @State private var showSheet = false

  var body: some View {
    VStack {
      Button("Show Custom Detent Sheet") {
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        CustomDetentSheetView()
          .presentationDetents([.fraction(0.3), .height(400)])
      }

    }
  }
}

struct CustomDetentSheetView: View {
  var body: some View {
    VStack {
      Text("This sheet uses custom detents.")
    }
    .padding()
  }
}

#Preview {
  CustomDetentView()
}
