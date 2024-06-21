import SwiftUI

struct DynamicContentSheetView: View {
  @State private var items = ["Item 1", "Item 2"]

  var body: some View {
    VStack {
      List(items, id: \.self) { item in
        Text(item)
      }
      Button("Add Item") {
        items.append("Item \(items.count + 1)")
      }
    }
    .padding()
  }
}

#Preview {
  DynamicContentSheetView()
}
