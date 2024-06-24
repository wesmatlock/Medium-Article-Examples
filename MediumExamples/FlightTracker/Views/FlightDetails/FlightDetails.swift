import SwiftUI

struct FlightDetails: View {
  @EnvironmentObject var uiModel: MainUIModel

  @State private var closeOpacity: Double = 0
  @State private var previousScrollOffset: CGFloat = 0

  @Binding var sheetPresented: Bool

  let flights: FlightInfo
  let minimumOffset: CGFloat = 5

  var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
        Section {
          // All the sections
          DepartureAndArrivalDetailView(flights: flights)

        } header: {
          flightDetailHeader
        }
      }
    }
  }

  fileprivate var flightDetailHeader: some View {
    ZStack {
      HStack(spacing: 30) {
        Image(systemName: "airplane.departure")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .background(.white)
          .frame(width: 40)
        
        VStack(alignment: .leading) {
          Text("Delta 666 - Mon, 25")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
            .frame(maxWidth: .infinity, alignment: .leading)

          Text("\(flights.departure.city) to \(flights.destination.city)")
            .font(.title2)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 5)
      }

      Button {
        uiModel.selectedDetent = .height(200)
      } label: {
        Image(systemName: "xmark.circle.fill")
          .font(.title)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .offset(x: 5, y: -15)
          .opacity(closeOpacity)
      }
      .buttonStyle(.plain)
    }
    .padding(.horizontal, 20)
    .padding(.top, 17)
    .padding(.bottom, 10)
    .background(
      Rectangle()
        .fill(.background)
    )
    .onChange(of: uiModel.selectedDetent) {
      withAnimation(.easeOut(duration: 0.2)) {
        closeOpacity = uiModel.selectedDetent == .height(200) ? 0 : 0.5
      }
    }
  }
}

#Preview {
  FlightDetails(sheetPresented: .constant(true), flights: FlightInfo.mockedFlights())
    .environmentObject(MainUIModel())
}
