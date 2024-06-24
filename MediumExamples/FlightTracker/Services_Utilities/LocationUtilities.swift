import CoreLocation
import Foundation

struct LocationUtilities {
  static func midpoint(
    between coordinate1: CLLocationCoordinate2D,
    and coordinate2: CLLocationCoordinate2D
  ) -> CLLocationCoordinate2D {
    let lat1 = coordinate1.latitude.degreesToRadians
    let long1 = coordinate1.longitude.degreesToRadians
    let lat2 = coordinate2.latitude.degreesToRadians
    let long2 = coordinate2.longitude.degreesToRadians

    let longDiff = long2 - long1

    let Bx = cos(lat2) * cos(longDiff)
    let By = cos(lat2) * sin(longDiff)

    let midLat = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + Bx) * (cos(lat1) + Bx) + By * By))
    let midLon = long1 + atan2(By, cos(lat1) + Bx)

    return CLLocationCoordinate2D(latitude: midLat.radiansToDegrees, longitude: midLon.radiansToDegrees)
  }

  static func distanceBetween(
    _ coordinate1: CLLocationCoordinate2D,
    and coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
      let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
      let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)

      return location1.distance(from: location2)
    }

  static func localizedDistanceBetween(_ coordinate1: CLLocationCoordinate2D, and coordinate2: CLLocationCoordinate2D) -> String {
    let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
    let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)

    let distanceInMeters = location1.distance(from: location2)

    // Create a Measurement object
    let distanceMeasurement = Measurement(value: distanceInMeters, unit: UnitLength.meters)

    // Create a MeasurementFormatter
    let formatter = MeasurementFormatter()
    formatter.unitOptions = .naturalScale
    formatter.unitStyle = .long
    formatter.numberFormatter.maximumFractionDigits = 0

    // Convert to user's preferred unit
    let formattedDistance = formatter.string(from: distanceMeasurement)

    return formattedDistance
  }
}
