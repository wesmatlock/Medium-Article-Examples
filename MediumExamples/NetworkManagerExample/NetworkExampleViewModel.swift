import SwiftUI
import Combine

@Observable
final class NetworkExampleViewModel {
  var data: [SampleData] = []
  private let apiClient: APIClient

  init(apiClient: APIClient = NetworkManager()) {
    self.apiClient = apiClient
  }

  func fetchData() async {
    guard let url = URL(string: "http://api.example.com/data") else { return }

    do {
      let fetchedData: [SampleData] = try await apiClient.get(url: url)
      DispatchQueue.main.async {
        self.data = fetchedData
      }
    } catch {
      print("Error fetching data: \(error.localizedDescription)")
    }
  }
}

// MARK: - Sample Data
struct SampleData: Decodable, Identifiable {
  var id = UUID()
  var name: String
}
