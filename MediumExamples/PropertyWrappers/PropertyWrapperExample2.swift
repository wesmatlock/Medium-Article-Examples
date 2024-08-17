import Foundation

@propertyWrapper
struct Clamped<Value: Comparable> {
  private var value: Value
  private let range: ClosedRange<Value>

  init(wrappedValue: Value, _ range: ClosedRange<Value>) {
    self.range = range
    self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
  }

  var wrappedValue: Value {
    get { value }
    set { value = min(max(newValue, range.lowerBound), range.upperBound) }
  }

  var projectedValue: (isAtLowerBound: Bool, isAtUpperBound: Bool) {
    (value == range.lowerBound, value == range.upperBound)
  }
}

//struct Example {
//  @Clamped(0...10) var number: Int = 0
//}
//
//struct ClampExample {
//  func clampA() {
//    var example = Example()
//    example.number = 15
//    print(example.$number.isAtUpperBound) // true
//    print(example.$number.isAtLowerBound) // false
//  }
//}

