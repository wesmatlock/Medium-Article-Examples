import SwiftUI

struct CircularLayoutView: View {
  let symbols = ["sun.max", "moon", "star", "cloud", "cloud.rain", "snow", "wind", "tornado", "hurricane", "thermometer"]

  var body: some View {
    CircularLayout() {
      ForEach(symbols, id: \.self) { symbol in
        Image(systemName: symbol)
          .resizable()
          .scaledToFit()
          .frame(width: 40, height: 40)
          .background(Color.green.opacity(0.1))
          .clipShape(Circle())
      }
      .padding()
    }
    .frame(width: 300, height: 300)
  }
}

#Preview {
  CircularLayoutView()
}
