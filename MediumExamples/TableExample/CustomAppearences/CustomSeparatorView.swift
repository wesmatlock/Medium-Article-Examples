import SwiftUI

struct CustomSeparatorView: View {
  var body: some View {
    Table(sampleData) {
      TableColumn("Item Details") { item in
        CustomRowView(item: item)
          .overlay(Divider(), alignment: .bottom)
      }
    }
    .navigationTitle("Customizing Separators")
  }
}

#Preview {
    CustomSeparatorView()
}
