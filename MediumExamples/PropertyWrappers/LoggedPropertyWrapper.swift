import Foundation

@propertyWrapper
struct Logged<Value> {
  private var value: Value
  private let label: String

  init(wrappedValue: Value, label: String) {
    self.value = wrappedValue
    self.label = label
    print("\(label): Initial value set to \(value)")
  }

  var wrappedValue: Value {
    get { value }
    set {
      print("\(label): Value changed from \(value) to \(newValue)")
      value = newValue
    }
  }
}


struct LogProperty {
  @Logged(label: "Example Number") @Clamped(0...10) var number = 5
}

struct LogExample {
  func logExample() {
    var example = LogProperty()
    example.number = 15 // Logs the change and clamps the value to 10
  }
}

// Testing the ClampExample
//let clampExample = ClampExample()
//clampExample.logExample()
