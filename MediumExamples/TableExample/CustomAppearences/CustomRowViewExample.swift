import SwiftUI

struct CustomRowViewExample: View {
  var body: some View {
    Table(sampleData) {
      TableColumn("Item Details") { item in
        CustomRowView(item: item)
      }
    }
    .navigationTitle("Custom Views for Rows")
  }
}

struct CustomRowView: View {
  let item: Item

  var body: some View {
    HStack {
      Image(systemName: item.iconName)
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(.blue)
      VStack(alignment: .leading) {
        Text(item.title)
          .font(.headline)
        Text(item.subtitle)
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      Spacer()
      Text(item.detail)
        .font(.body)
        .foregroundColor(.secondary)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
  }
}


#Preview {
  CustomRowViewExample()
}
