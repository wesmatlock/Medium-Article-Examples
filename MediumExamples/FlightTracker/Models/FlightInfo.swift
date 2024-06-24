import Foundation

struct FlightInfo {
  let departure: AirportAnnotation
  let destination: AirportAnnotation
}

extension FlightInfo: Equatable {
  static func == (lhs: FlightInfo, rhs: FlightInfo) -> Bool {
    lhs.departure.id == rhs.departure.id &&
    lhs.destination.id == rhs.destination.id
  }
}

// MARK: - MOCK DATA
extension FlightInfo {
  static func mockedFlights() -> FlightInfo {
    if let firstRandomAirport = AirportAnnotation.MockLocations.randomElement() {
      let filteredArray = AirportAnnotation.MockLocations.filter { $0 != firstRandomAirport }
      if let secondRandomAirport = filteredArray.randomElement() {
        return FlightInfo(departure: firstRandomAirport, destination: secondRandomAirport)
      }
    }
    return FlightInfo(departure: AirportAnnotation.MockLocations[0], destination: AirportAnnotation.MockLocations[1])
  }
}
