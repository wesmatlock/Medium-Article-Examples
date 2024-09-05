import SwiftUI

struct MultiSelectDropdownMenu: View {
  @State private var isExpanded = false
  @State private var selectedOptions: Set<String> = []
  let options = ["Swift", "Kotlin", "JavaScript", "Python", "Ruby"]
  
  var body: some View {
    VStack(alignment: .leading) {
      Button(action: { isExpanded.toggle() }) {
        HStack {
          Text(selectedOptions.isEmpty ? "Select Options" : selectedOptions.joined(separator: ", "))
          Spacer()
          Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
      }
      
      if isExpanded {
        VStack {
          ForEach(options, id: \.self) { option in
            HStack {
              Text(option)
              Spacer()
              if selectedOptions.contains(option) {
                Image(systemName: "checkmark")
              }
            }
            .padding()
            .onTapGesture {
              if selectedOptions.contains(option) {
                selectedOptions.remove(option)
              } else {
                selectedOptions.insert(option)
              }
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
  MultiSelectDropdownMenu()
}
