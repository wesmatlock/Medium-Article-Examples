import SwiftUI

struct RecipeDetailView: View {
  let recipe: Recipe

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Image(recipe.imageName)
          .resizable()
          .scaledToFit()
        Text("Ingredients")
          .font(.title2)
          .padding(.top)
        ForEach(recipe.ingredients, id: \.self) { ingredient in
          Text("• \(ingredient)")
        }
        Text("Instructions")
          .font(.title2)
          .padding(.top)
        Text(recipe.instructions)
          .padding(.top, 5)
      }
      .padding()
    }
    .navigationTitle(recipe.name)
  }
}

#Preview("Spaghetti Carbonara") {
  RecipeDetailView(recipe: DataLoader.loadSampleRecipes()[0])
}

#Preview("Margherita Pizza") {
  RecipeDetailView(recipe: DataLoader.loadSampleRecipes()[1])
}
