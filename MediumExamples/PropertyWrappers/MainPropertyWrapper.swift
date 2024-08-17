//import Foundation
//
//@propertyWrapper
//struct Clamped<Value: Comparable> {
//  private var value: Value
//  private let range: ClosedRange<Value>
//
//  init(wrappedValue: Value, _ range: ClosedRange<Value>) {
//    self.range = range
//    self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
//  }
//
//  init(_ range: ClosedRange<Value>) where Value: ExpressibleByIntegerLiteral {
//    self.range = range
//    self.value = range.lowerBound // Or some other default value within the range
//  }
//
//  var wrappedValue: Value {
//    get { value }
//    set { value = min(max(newValue, range.lowerBound), range.upperBound) }
//  }
//}
//
//struct Example {
//  @Clamped(0...10) var number: Int
//
//  init(number: Int) {
//    self._number = Clamped(wrappedValue: number, 0...10)
//  }
//}
//
//struct ClampExample {
//  func clampA() {
//    var example = Example(number: 15)
//    print(example.number) // 10, because 15 is clamped to the upper bound 10
//    example.number = -5
//    print(example.number) // 0, because -5 is clamped to the lower bound 0
//  }
//}
