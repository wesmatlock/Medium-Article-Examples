import Foundation

struct Recipe: Identifiable, Decodable, Hashable {
  let id: UUID
  let name: String
  let imageName: String
  let ingredients: [String]
  let instructions: String
}
