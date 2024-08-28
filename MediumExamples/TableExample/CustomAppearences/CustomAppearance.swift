import SwiftUI

struct CustomAppearance: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Custom Row Backgrounds", destination: CustomRowBackgroundView())
        NavigationLink("Conditional Row Styling", destination: ConditionalRowStylingView())
        NavigationLink("Custom Views for Rows", destination: CustomRowViewExample())
        NavigationLink("Customizing Separators", destination: CustomSeparatorView())
        NavigationLink("Adding Row Actions", destination: RowActionsView())
        NavigationLink("Animating Row Changes", destination: AnimatingRowChangesView())
//        NavigationLink("Custom Selection Style", destination: CustomSelectionStyleView())
      }
      .navigationTitle("Custom TableView")
    }
  }}

#Preview {
    CustomAppearance()
}

import SwiftUI

struct Item: Identifiable {
  let id = UUID()
  let title: String
  let subtitle: String
  let detail: String
  let iconName: String
  var isSelected: Bool = false
  var isImportant: Bool = false
}

let sampleData: [Item] = [
  Item(title: "Item 1", subtitle: "Subtitle 1", detail: "Detail 1", iconName: "star"),
  Item(title: "Item 2", subtitle: "Subtitle 2", detail: "Detail 2", iconName: "heart"),
  Item(title: "Item 3", subtitle: "Subtitle 3", detail: "Detail 3", iconName: "bolt"),
]
