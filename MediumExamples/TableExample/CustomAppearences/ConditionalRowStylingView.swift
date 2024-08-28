import SwiftUI

struct ConditionalRowStylingView: View {
  @State private var items = sampleData

  var body: some View {
    Table(items) {
      TableColumn("Title") { item in
        Text(item.title)
          .padding()
          .background(item.isSelected ? Color.blue : Color.clear)
          .cornerRadius(8)
          .shadow(radius: item.isSelected ? 5 : 0)
          .onTapGesture {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
              items[index].isSelected.toggle()
            }
          }
      }
    }
    .navigationTitle("Conditional Row Styling")
  }
}
#Preview {
  ConditionalRowStylingView()
}
