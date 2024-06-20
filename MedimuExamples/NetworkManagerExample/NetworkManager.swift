import Foundation

protocol APIClient {
  func get<T: Decodable>(url: URL) async throws -> T
  func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
}

final class NetworkManager: APIClient {
  private let urlCache: URLCache

  init(urlCache: URLCache = .shared) {
    self.urlCache = urlCache
  }

  func get<T>(url: URL) async throws -> T where T : Decodable {
    if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) {
      let decodeData = try JSONDecoder().decode(T.self, from: cachedResponse.data)
      return decodeData
    }
    let (data, response) = try await URLSession.shared.data(from: url)

    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode.isMultiple(of: 200) {
      let cacheResponse = CachedURLResponse(response: httpResponse, data: data)
      urlCache.storeCachedResponse(cacheResponse, for: URLRequest(url: url))
    }
    
    let decodeData = try JSONDecoder().decode(T.self, from: data)
    return decodeData
  }

  func post<T, U>(url: URL, body: U) async throws -> T where T : Decodable, U : Encodable {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(body)

    let (data, _) = try await URLSession.shared.data(for: request)
    let decodeData = try JSONDecoder().decode(T.self, from: data)
    return decodeData
  }
}
