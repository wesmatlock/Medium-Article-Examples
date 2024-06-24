import Foundation

extension Double {
  var degreesToRadians: Double {
    return self * .pi / 180
  }

  var radiansToDegrees: Double {
    return self * 180 / .pi
  }
}
