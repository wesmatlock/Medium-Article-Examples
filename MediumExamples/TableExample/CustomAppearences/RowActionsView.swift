import SwiftUI

struct RowActionsView: View {
  var body: some View {
    Table(sampleData) {
      TableColumn("Title") { item in
        Text(item.title)
          .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
              print("Delete \(item.title)")
            } label: {
              Label("Delete", systemImage: "trash")
            }
            Button {
              print("Favorite \(item.title)")
            } label: {
              Label("Favorite", systemImage: "star")
            }
          }
      }
    }
    .navigationTitle("Adding Row Actions")
  }
}

#Preview {
    RowActionsView()
}
