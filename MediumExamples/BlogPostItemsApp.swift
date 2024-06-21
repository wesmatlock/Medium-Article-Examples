import SwiftUI

@main
struct MedimuExamplesApp: App {

  init() {
    // Set up URLCache - Efficient Network Caching in Swift with URLCache Post
    let memoryCapacity = 20 * 1024 * 1024 // 20 MB
    let diskCapacity = 100 * 1024 * 1024 // 100 MB
    let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myCache")
    URLCache.shared = cache
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
