import SwiftUI

struct DepartureAndArrivalDetailView: View {
  @State private var departurePosition: CGFloat = 0
  @State private var arrivalPosition: CGFloat = 0
  @State private var sectionHeight: CGFloat = 0
  private let coordNameSpace: String  = "DepartureArrivalSection"
  
  let flights: FlightInfo

  var body: some View {
    HStack(alignment: .top) {
      ArrowView(departurePosition: departurePosition, arrivalPosition: arrivalPosition)

      VStack {
        HStack {
          Text(flights.departure.code)
            .font(.title)
            .fontWeight(.bold)
            .overlay(
              Rectangle()
                .fill(.clear)
                .frame(height: 0.5)
                .overlay(
                  GeometryReader { proxy in
                    // We want to center the Arrow view with the text
                    Color.clear.preference(key: TextCenter.self, value: proxy.frame(in: .named(coordNameSpace)).minY)
                  }
                )
                .onPreferenceChange(TextCenter.self) { offset in
                  // We want to center the Arrow view with the text
                  departurePosition = offset
                }
            )

          Spacer()

          Text("3:30 PM")
            .font(.title)
            .fontWeight(.semibold)
            .textCase(.uppercase)
            .foregroundStyle(.green)
        }

        Group {
          HStack {
            Text(flights.departure.name)
            Spacer()
            Text("Scheduled")
              .fontWeight(.bold)
          }

          HStack {
            Text("Terminal C - Gate 35")
            Spacer()
            Text("in 4h 00m")
          }
        }
        .font(.caption)
        .fontWeight(.regular)
        .foregroundStyle(.secondary)

        ZStack {
          Rectangle()
            .frame(height: 0.5)
            .opacity(0.25)

          Text("Total flight time: 2h 00m - \(LocationUtilities.localizedDistanceBetween(flights.departure.coordinate, and: flights.destination.coordinate))")
            .font(.caption)
            .fontWeight(.regular)
            .foregroundStyle(.secondary)
            .padding(.vertical, 10)
            .padding(.horizontal, 3)
            .background(.background)
        }

        VStack {
          HStack {
            Text(flights.destination.code)
              .font(.title)
              .fontWeight(.bold)
              .overlay(
                Rectangle()
                  .fill(.clear)
                  .frame(height: 0.5)
                  .overlay(
                    GeometryReader { proxy in
                      // We want to center the Arrow view with the text
                      Color.clear.preference(key: TextCenter.self, value: proxy.frame(in: .named(coordNameSpace)).minY)
                    }
                  )
                  .onPreferenceChange(TextCenter.self) { offset in
                    // We want to center the Arrow view with the text
                    arrivalPosition = offset
                  }
              )

            Spacer()

            Text("7:30 PM")
              .font(.title)
              .fontWeight(.semibold)
              .textCase(.uppercase)
              .foregroundStyle(.green)
          }

          Group {
            HStack {
              Text(flights.destination.name)
              Spacer()
              Text("Scheduled")
                .fontWeight(.bold)
            }
            .font(.caption)

            HStack {
              Text("Terminal 3 - Gate 7B")
                .fontWeight(.bold)
              Spacer()
              Text("in 1h 30m")
                .fontWeight(.regular)
            }
            .font(.caption)

            Text("Baggage Claim: D")
              .font(.caption)
              .fontWeight(.regular)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .foregroundStyle(.secondary)
        }
      }
      .padding(.leading, 10)
    }
    .frame(maxWidth: .infinity)
    .overlay(
      GeometryReader { proxy in
        Color.clear.preference(key: SectionHeight.self, value: proxy.frame(in: .named(coordNameSpace)).minY)
      }
    )
    .onPreferenceChange(SectionHeight.self, perform: { value in
      sectionHeight = value
    })
    .coordinateSpace(name: coordNameSpace)
    .padding(.leading, 10)
    .padding(.trailing)
    .padding(.bottom, 20)
  }
}

#Preview {
  DepartureAndArrivalDetailView(flights: FlightInfo.mockedFlights())
}

// MARK: - ArrowView
struct ArrowView: View {
  private let departurePosition: CGFloat
  private let arrivalPosition: CGFloat

  init(departurePosition: CGFloat, arrivalPosition: CGFloat) {
    self.departurePosition = departurePosition
    self.arrivalPosition = arrivalPosition
  }

  var body: some View {
    ZStack {
      Image(systemName: "arrow.up.right.circle.fill")
        .foregroundStyle(.background, .green)
        .background(
          Circle()
            .fill(.background)
        )
        .offset(y: departurePosition - 10)

      Image(systemName: "arrow.down.right.circle.fill")
        .foregroundStyle(.background, .green)
        .background(
          Circle()
            .fill(.background)
        )
        .offset(y: arrivalPosition - 10)
    }
    .fontWeight(.bold)
    .background(
      Rectangle()
        .frame(width: 0.5, alignment: .center)
        .frame(height: max(arrivalPosition - 10, 0))
        .foregroundStyle(.primary.opacity(0.25)),
      alignment: .top
    )
  }
}

// MARK: - TextCenter
// Used to center the text with a subview
struct TextCenter: PreferenceKey {
  typealias Value = CGFloat

  static var defaultValue: Value = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

// MARK: - SectionHeight
// Used to figure out the hight of the line
struct SectionHeight: PreferenceKey {
  typealias Value = CGFloat

  static var defaultValue: Value = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
