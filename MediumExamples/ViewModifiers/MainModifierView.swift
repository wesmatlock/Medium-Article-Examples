import SwiftUI

struct MainModifierView: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      .padding()
      .background(Color.blue)
      .foregroundStyle(Color.white)
      .cornerRadius(10)

    Image(systemName: "star.fill")
      .resizable()
      .frame(width: 100, height: 100)
      .roundedCornerShadow(radius: 20, shadowColor: .green, shadowRadius: 5)
      .foregroundStyle(.yellow)

    Text("Parameterized Modifier")
      .padding()
      .parameterizedModifierView(radius: 15, shadowColor: .black, shadowRadius: 10)

    Text("Pulsating Modifier")
      .padding()
      .pulsating()

    Text("Composable Modifier")
      .padding()
      .borderAndShadow(color: .blue, width: 2)

    Text("Environment Values")
      .padding()
      .customFont()
  }
}

// MARK: - RoundedCornerShadow
struct RounderCornerShadow: ViewModifier {
  var radius: CGFloat
  var shadowColor: Color
  var shadowRadius: CGFloat
  
  func body(content: Content) -> some View {
    content
      .cornerRadius(radius)
      .shadow(color: shadowColor, radius: shadowRadius)
  }
}

extension View {
  func roundedCornerShadow(radius: CGFloat, shadowColor: Color, shadowRadius: CGFloat) -> some View {
    self.modifier(RounderCornerShadow(radius: radius, shadowColor: shadowColor, shadowRadius: shadowRadius))
  }
}

// MARK: - ParameterizedModifier
struct ParameterizedModifierView: ViewModifier {
  var radius: CGFloat
  var shadowColor: Color
  var shadowRadius: CGFloat

  func body(content: Content) -> some View {
    content
      .cornerRadius(radius)
      .shadow(color: shadowColor, radius: radius)
  }
}

extension View {
  func parameterizedModifierView(radius: CGFloat, shadowColor: Color, shadowRadius: CGFloat) -> some View {
    self.modifier(ParameterizedModifierView(radius: radius, shadowColor: shadowColor, shadowRadius: shadowRadius))
  }
}

// MARK: - PulsatingModifier
struct PulsatingModifier: ViewModifier {
  @State private var scale: CGFloat = 1.0

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
          scale = 1.2
        }
      }
  }
}

extension View {
  func pulsating() -> some View {
    self.modifier(PulsatingModifier())
  }
}

// MARK: - Composable Modifier
struct RoundedCornerShadow: ViewModifier {
  var radius: CGFloat
  var shadowColor: Color
  var shadowRadius: CGFloat

  func body(content: Content) -> some View {
    content
      .cornerRadius(radius)
      .shadow(color: shadowColor, radius: shadowRadius)
  }
}

struct BorderAndShadow: ViewModifier {
  var color: Color
  var width: CGFloat

  func body(content: Content) -> some View {
    content
      .border(color, width: width)
      .modifier(RoundedCornerShadow(radius: 10, shadowColor: .black, shadowRadius: 5))
  }
}

extension View {
  func borderAndShadow(color: Color, width: CGFloat) -> some View {
    self.modifier(BorderAndShadow(color: color, width: width))
  }
}

//MARK: - Environmental Values
struct CustomFontModifier: ViewModifier {
  @Environment(\.sizeCategory) var sizeCategory

  func body(content: Content) -> some View {
    content
      .font(.system(size: sizeCategory.isAccessibilityCategory ? 24 : 16))
  }
}

extension View {
  func customFont() -> some View {
    self.modifier(CustomFontModifier())
  }
}

#Preview {
  MainModifierView()
}
