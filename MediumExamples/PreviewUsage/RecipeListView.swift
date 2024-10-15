import SwiftUI

struct RecipeListView: View {
  let recipes: [Recipe]

  var body: some View {
    NavigationStack {
      List(recipes) { recipe in
        NavigationLink(value: recipe) {
          HStack {
            Image(recipe.imageName)
              .resizable()
              .frame(width: 50, height: 50)
              .cornerRadius(5)
            Text(recipe.name)
              .font(.headline)
          }
        }
      }
      .navigationTitle("Recipes")
      .navigationDestination(for: Recipe.self) { recipe in
        RecipeDetailView(recipe: recipe)
      }
    }
  }
}

#Preview {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
}

#Preview("Dark Mode") {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
    .environment(\.colorScheme, .dark)
}

#Preview("Large Text") {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
    .environment(\.sizeCategory, .accessibilityExtraLarge)
}

#Preview("French Locale") {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
    .environment(\.locale, Locale(identifier: "fr"))
}

#Preview("Custom Size") {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
    .frame(width: 320, height: 568) // iPhone SE size
}

struct DarkModeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.environment(\.colorScheme, .dark)
  }
}

extension View {
  func darkMode() -> some View {
    modifier(DarkModeModifier())
  }
}

#Preview("Dark Mode") {
  RecipeListView(recipes: DataLoader.loadSampleRecipes())
    .darkMode()
}
