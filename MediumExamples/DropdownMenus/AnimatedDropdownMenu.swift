import SwiftUI

struct AnimatedDropdownMenu: View {
  @Namespace private var animationNamespace
  @State private var isExpanded = false
  @State private var selectedOption = "Select an Option"
  let options = ["Option 1", "Option 2", "Option 3"]

  var body: some View {
    VStack {
      Button(action: {
        withAnimation(.spring()) {
          isExpanded.toggle()
        }
      }) {
        HStack {
          Text(selectedOption)
          Spacer()
          Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
        .matchedGeometryEffect(id: "dropdown", in: animationNamespace)
      }

      if isExpanded {
        VStack {
          ForEach(options, id: \.self) { option in
            Text(option)
              .padding()
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color.white)
              .onTapGesture {
                withAnimation(.spring()) {
                  selectedOption = option
                  isExpanded = false
                }
              }
              .matchedGeometryEffect(id: "dropdown-\(option)", in: animationNamespace)
          }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .transition(.scale)
      }
    }
    .padding()
  }
}

#Preview {
    AnimatedDropdownMenu()
}
