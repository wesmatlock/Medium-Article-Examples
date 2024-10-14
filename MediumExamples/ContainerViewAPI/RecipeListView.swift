import SwiftUI

struct RecipeListView: View {
  var recipes: [Recipe]

  var body: some View {
    let recipeNodes = recipes.map { RecipeNode.recipe($0) }
    List {
      OutlineGroup(recipeNodes, children: \.children) { node in
        switch node {
        case .recipe(let recipe):
          Text(recipe.name)
            .font(.headline)
        case .ingredient(let ingredient):
          Text("\(ingredient.name): \(ingredient.quantity)")
            .font(.subheadline)
        }
      }
    }
  }
}

//protocol RecipeItem: Identifiable {
//  var id: UUID { get }
//  var name: String { get }
//}
//
//extension Recipe: RecipeItem {}
//extension Ingredient: RecipeItem {}
//
//extension Recipe {
//  var children: [any RecipeItem]? {
//    return ingredients
//  }
//}
//
//extension Ingredient {
//  var children: [any RecipeItem]? {
//    return nil
//  }
//}
