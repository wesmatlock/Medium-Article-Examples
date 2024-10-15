import Foundation

struct DataLoader {
  static func loadSampleRecipes() -> [Recipe] {
    // Iterate over all bundles to find the one containing the resource
    for bundle in Bundle.allBundles {
      if let url = bundle.url(forResource: "SampleRecipes", withExtension: "json") {
        do {
          let data = try Data(contentsOf: url)
          let recipes = try JSONDecoder().decode([Recipe].self, from: data)
          return recipes
        } catch {
          fatalError("Failed to decode SampleRecipes.json: \(error)")
        }
      }
    }
    fatalError("SampleRecipes.json not found in any bundle.")
  }
}
//struct DataLoader {
//  static func loadSampleRecipes() -> [Recipe] {
//    guard let url = Bundle.preview.url(forResource: "SampleRecipes", withExtension: "json") else {
//      fatalError("SampleRecipes.json not found in Preview Content.")
//    }
//    do {
//      let data = try Data(contentsOf: url)
//      let recipes = try JSONDecoder().decode([Recipe].self, from: data)
//      return recipes
//    } catch {
//      fatalError("Failed to decode SampleRecipes.json: \(error)")
//    }
//  }
//}
//
//extension Bundle {
//  static var preview: Bundle = {
//    // Loop through all bundles to find the preview bundle
//    for bundle in Bundle.allBundles {
//      if bundle.bundlePath.hasSuffix(".previews") {
//        return bundle
//      }
//    }
//    // Fallback to the main bundle if not found (for production)
//    return Bundle.main
//  }()
//}
