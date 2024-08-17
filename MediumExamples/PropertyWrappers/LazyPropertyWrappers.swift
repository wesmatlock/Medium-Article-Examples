import Foundation

@propertyWrapper
struct LazyDependent<Value> {
  private var value: Value?
  private let initializer: () -> Value

  init(wrappedValue: @autoclosure @escaping () -> Value) {
    self.initializer = wrappedValue
  }

  var wrappedValue: Value {
    mutating get {
      if let value = value {
        return value
      } else {
        let newValue = initializer()
        self.value = newValue
        return newValue
      }
    }
    mutating set {
      value = newValue
    }
  }

  mutating func reset() {
    value = nil
  }
}

struct LazyProperty {
  var baseValue: Int
  @LazyDependent var dependentValue: Int

  init(baseValue: Int) {
    self.baseValue = baseValue
    self._dependentValue = LazyDependent(wrappedValue: baseValue * 2)
  }

  mutating func resetDependentValue() {
    _dependentValue.reset()
  }
}

struct LazyPropertyExample {
  func example() {
    var example = LazyProperty(baseValue: 10)
    print(example.dependentValue) // 20
    example.baseValue = 20
    example.resetDependentValue()  // Reset using the public method
    print(example.dependentValue) // 40 (after reset)
  }
}
