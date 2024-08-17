import Foundation

@propertyWrapper
struct RemoteValue<Value> {
  private var value: Value?
  private let fetchValue: () async -> Value

  init(fetchValue: @escaping () async -> Value) {
    self.fetchValue = fetchValue
  }

  var wrappedValue: Value? {
    value
  }

  mutating func fetch() async -> Value {
    if let value = value {
      return value
    } else {
      let fetchedValue = await fetchValue()
      self.value = fetchedValue
      return fetchedValue
    }
  }
}

struct RemoteExample {
  @RemoteValue(fetchValue: {
    // Simulate network delay
    try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    return "Fetched Data"
  }) var data: String?

  mutating func loadData() async {
    let data = await _data.fetch()
    print(data) // Prints "Fetched Data" after 2 seconds
  }
}
//
//Task {
//  var example = RemoteExample()
//  await example.loadData()
//}
