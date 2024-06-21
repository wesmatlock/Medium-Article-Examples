import SwiftUI

struct NavigationContentView: View {
  @State private var showSheet = false

  var body: some View {
    VStack {
      Button("Show Sheet with Navigation") {
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        NavigationSheetView()
          .presentationDetents([.medium, .large])
      }
    }
  }
}

struct NavigationSheetView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: DetailView(item: "Item 1")) {
          Text("Item 1")
        }
        NavigationLink(destination: DetailView(item: "Item 2")) {
          Text("Item 2")
        }
      }
      .navigationTitle("Items")
    }
  }
}

struct DetailView: View {
  let item: String

  var body: some View {
    Text("Details about \(item)")
      .navigationTitle(item)
  }
}

#Preview {
  NavigationContentView()
}
