import SwiftUI

struct GateDepartureBanner: View {
  var body: some View {
    HStack {
      Text("Gate Departure in 2h 35m")
        .fontWeight(.semibold)
        .foregroundStyle(.green)
        .frame(maxWidth: .infinity, alignment: .leading)

      Label("D13", systemImage: "figure.walk.circle.fill")
        .fontWeight(.semibold)
        .foregroundStyle(.black)
        .padding(5)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(.yellow)
        )
    }
    .padding([.vertical, .horizontal], 15)
    .background(
      Rectangle()
        .fill(.green.opacity(0.10))
    )
    .overlay(
      Rectangle()
        .frame(height: 0.25, alignment: .top)
        .foregroundStyle(.green.opacity(0.75)),
      alignment: .top
    )
    .overlay(
      Rectangle()
        .frame(height: 0.25, alignment: .top)
        .foregroundStyle(.green.opacity(0.75)),
      alignment: .bottom
    )
  }
}

#Preview {
  GateDepartureBanner()
}
