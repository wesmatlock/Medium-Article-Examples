import SwiftUI

struct SearchableDropdownMenu: View {
  @State private var isExpanded = false
  @State private var selectedOption = "Select an Option"
  @State private var searchText = ""
  let options = ["Apple", "Banana", "Orange", "Mango", "Pineapple", "Grapes"]

  var filteredOptions: [String] {
    if searchText.isEmpty {
      return options
    } else {
      return options.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
  }

  var body: some View {
    VStack {
      Button(action: { isExpanded.toggle() }) {
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
        VStack {
          TextField("Search...", text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

          ForEach(filteredOptions, id: \.self) { option in
            Text(option)
              .padding()
              .onTapGesture {
                selectedOption = option
                isExpanded = false
              }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
      }
    }
    .padding()
  }
}
#Preview {
    SearchableDropdownMenu()
}
