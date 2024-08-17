import Foundation

@propertyWrapper
class ThreadSafe<Value> {
  private var value: Value
  private let queue = DispatchQueue(label: UUID().uuidString)

  init(wrappedValue: Value) {
    self.value = wrappedValue
  }

  var wrappedValue: Value {
    get {
      return queue.sync { value }
    }
    set {
      queue.sync { value = newValue }
    }
  }
}

struct ThreadSafeProperty {
  @ThreadSafe var count: Int = 0
}

struct ThreadSafeExample {
  func example() {
    let example = ThreadSafeProperty()
    DispatchQueue.concurrentPerform(iterations: 1000) { _ in
      example.count += 1
    }
    print(example.count) // 1000
  }
}

