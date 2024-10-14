import Foundation

enum RecipeNode: Identifiable {
  case recipe(Recipe)
  case ingredient(Ingredient)

  var id: UUID {
    switch self {
    case .recipe(let recipe):
      return recipe.id
    case .ingredient(let ingredient):
      return ingredient.id
    }
  }

  var name: String {
    switch self {
    case .recipe(let recipe):
      return recipe.name
    case .ingredient(let ingredient):
      return ingredient.name
    }
  }

  var children: [RecipeNode]? {
    switch self {
    case .recipe(let recipe):
      return recipe.ingredients.map { RecipeNode.ingredient($0) }
    case .ingredient:
      return nil
    }
  }
}
