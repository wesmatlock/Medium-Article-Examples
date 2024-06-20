import Foundation

struct CachedNetwork {

  func fetchDataWithCacheCheck(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    if let cachedData = getCachedData(for: url) {
      print("Returning cached data")
      completion(cachedData, nil, nil)
    } else {
      print("Fetching data from network")
      fetchData(from: url, completion: completion)
    }
  }
  
  func getCachedData(for url: URL) -> Data? {
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
    if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
      return cachedResponse.data
    }
    return nil
  }
  
  func fetchData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    let session = URLSession.shared

    let task = session.dataTask(with: request) { data, response, error in
      if let data = data, let response = response {
        // Save the response in cache
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
      }
      completion(data, response, error)
    }
    task.resume()
  }
}

/**  Example Usage:
 let url = URL(string: "https://api.example.com/data")!

 fetchDataWithCacheCheck(from: url) { data, response, error in
 if let error = error {
 print("Failed to fetch data: \(error)")
 } else if let data = data {
 print("Data received: \(data)")
 }
 }

 */
