import SwiftUI

struct AnimatingRowChangesView: View {
  @State private var rowSampleData = sampleData

  var body: some View {
    List(rowSampleData) { item in
      ForEach(rowSampleData.indices, id: \.self) { index in
        Text(rowSampleData[index].title)
          .padding()
          .background(rowSampleData[index].isImportant ? Color.yellow : Color.clear)
          .scaleEffect(rowSampleData[index].isImportant ? 1.05 : 1.0)
          .animation(.easeInOut(duration: 0.3), value: rowSampleData[index].isImportant)
          .onTapGesture {
            rowSampleData[index].isImportant.toggle()
          }
      }
    }
    .navigationTitle("Animating Row Changes")
  }
}

#Preview {
    AnimatingRowChangesView()
}
