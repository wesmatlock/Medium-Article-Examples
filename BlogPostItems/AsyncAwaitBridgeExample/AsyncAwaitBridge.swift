import Foundation

func fetchData() async -> Data {
  // Simulate a network request
  return Data()
}

//let data = await fetchData()

// Closure Based Function
func fetchData(completion: @escaping (Data?, Error?) -> Void) {
  // Simulate a network request
  DispatchQueue.global().async {
    // Assume data fetched
    let data = Data()
    completion(data, nil)
  }
}

// Converted Closure to Async
func fetchDataAsync() async throws -> Data {
  return try await withCheckedThrowingContinuation { continuation in
    fetchData { data, error in
      if let data = data {
        continuation.resume(returning: data)
      } else if let error = error {
        continuation.resume(throwing: error)
      } else {
        continuation.resume(throwing: URLError(.badServerResponse))
      }
    }
  }
}

//Hybrid Approach
func fetchDataHybrid(completion: @escaping (Data?, Error?) -> Void) {
  if #available(iOS 15.0, *) {
    Task {
      do {
        let data = try await fetchDataAsync()
        completion(data, nil)
      } catch {
        completion(nil, error)
      }
    }
  } else {
    // Fallback on earlier versions
    fetchData { data, error in
      completion(data, error)
    }
  }
}
