import SwiftUI

struct AdvancedContentView: View {
  @State private var showSheet = false

  var body: some View {
    VStack {
      Button("Show Advanced Sheet") {
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        AdvancedSheetView()
          .presentationDetents([.medium, .fraction(0.5), .height(500)])
      }
    }
  }
}

struct AdvancedSheetView: View {
  @State private var items = ["Item 1", "Item 2", "Item 3"]

  var body: some View {
    NavigationView {
      VStack {
        List(items, id: \.self) { item in
          NavigationLink(destination: AdvancedDetailView(item: item)) {
            Text(item)
          }
        }
        Button("Add Item") {
          items.append("Item \(items.count + 1)")
        }
      }
      .navigationTitle("Dynamic Items")
      .padding()
    }
  }
}

struct AdvancedDetailView: View {
  let item: String

  var body: some View {
    Text("Details about \(item)")
      .navigationTitle(item)
  }
}

#Preview {
  AdvancedContentView()
}
