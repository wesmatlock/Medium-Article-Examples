import Foundation

struct Ingredient: Identifiable {
  let id = UUID()
  let name: String
  let quantity: String
}

struct Recipe: Identifiable {
  let id = UUID()
  let name: String
  let ingredients: [Ingredient]
}

let sampleRecipes = [
  Recipe(name: "Spaghetti Bolognese", ingredients: [
    Ingredient(name: "Spaghetti", quantity: "200g"),
    Ingredient(name: "Ground Beef", quantity: "150g"),
    Ingredient(name: "Tomato Sauce", quantity: "100ml")
  ]),
  Recipe(name: "Chicken Salad", ingredients: [
    Ingredient(name: "Chicken Breast", quantity: "200g"),
    Ingredient(name: "Lettuce", quantity: "1 head"),
    Ingredient(name: "Cherry Tomatoes", quantity: "100g")
  ])
]
