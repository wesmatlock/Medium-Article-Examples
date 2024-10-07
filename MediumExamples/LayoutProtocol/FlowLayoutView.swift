import SwiftUI

struct FlowLayoutView: View {
  let symbols = ["sun.max", "moon", "star", "cloud", "cloud.rain", "snow", "wind", "tornado", "hurricane", "thermometer"]
  
  var body: some View {
    FlowLayout(spacing: 12) {
      ForEach(symbols, id: \.self) { symbol in
        Image(systemName: symbol)
          .resizable()
          .scaledToFit()
          .frame(width: 50, height: 50)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
      }
    }
    .padding()
  }
}

#Preview {
  FlowLayoutView()
}
