import SwiftUI

struct AdvancedDropdownMenu: View {
  @State private var isExpanded: Bool = false
  @State private var selectedOption: String = "Select an Option"
  let options = ["Option 1", "Option 2", "Option 3"]

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Button(action: { withAnimation { isExpanded.toggle() } }) {
        HStack {
          Text(selectedOption)
          Spacer()
          Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
      }

      if isExpanded {
        ForEach(options, id: \.self) { option in
          Text(option)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .onTapGesture {
              withAnimation {
                selectedOption = option
                isExpanded = false
              }
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }
}

#Preview {
    AdvancedDropdownMenu()
}
