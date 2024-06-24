import SwiftUI

struct FlightArrivalData: Identifiable {
  let id: UUID
  let name: String
  let value: Double
  let statusColor: Color

  init(id: UUID = UUID(), name: String, value: Double, statusColor: Color) {
    self.id = id
    self.name = name
    self.value = value
    self.statusColor = statusColor
  }
}

extension FlightArrivalData {
  static func generateMockData() -> [FlightArrivalData] {
    var mockData = [FlightArrivalData]()

    for status in FlightStatus.allCases {
      mockData.append(
        FlightArrivalData(
          name: status.description,
          value: Double.random(in: 0.0...0.4),
          statusColor: status.color
        )
      )
    }
    return mockData
  }
}
