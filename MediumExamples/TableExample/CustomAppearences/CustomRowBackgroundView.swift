import SwiftUI

struct CustomRowBackgroundView: View {
  var body: some View {
    Table(sampleData) {
      TableColumn("Title") { item in
        Text(item.title)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.blue.opacity(0.1))
          )
          .padding(.vertical, 4)
      }
      TableColumn("Subtitle") { item in
        Text(item.subtitle)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.green.opacity(0.1))
          )
          .padding(.vertical, 4)
      }
      TableColumn("Detail") { item in
        Text(item.detail)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.pink.opacity(0.1))
          )
          .padding(.vertical, 4)
      }
    }
    .navigationTitle("Custom Row Backgrounds")
  }
}
#Preview {
  CustomRowBackgroundView()
}
