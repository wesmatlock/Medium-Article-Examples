import SwiftUI

struct MainDynamicTypeView: View {
  var body: some View {
//    DynamicTypeView()
    CustomFontView()
  }
}

  //  CustomFontView()
  //    .environment(\.sizeCategory, .extraExtraLarge) // For previewing different text sizes
  //  Group {
  //    CustomFontView()
  //      .previewDisplayName("Default Size")
  //    CustomFontView()
  //      .environment(\.sizeCategory, .extraSmall)
  //      .previewDisplayName("Extra Small Size")
  //    CustomFontView()
  //      .environment(\.sizeCategory, .extraExtraLarge)
  //      .previewDisplayName("Extra Extra Large Size")
  //    CustomFontView()
  //      .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
  //      .previewDisplayName("Accessibility 3XL Size")
  //  }

#Preview {
  AccessibleForm()
    .environment(\.sizeCategory, .extraExtraLarge) // For previewing different text sizes
}

struct DynamicTypeView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Large Title")
        .font(.largeTitle)
      Text("Title")
        .font(.title)
      Text("Headline")
        .font(.headline)
      Text("Subheadline")
        .font(.subheadline)
      Text("Body")
        .font(.body)
      Text("Callout")
        .font(.callout)
      Text("Footnote")
        .font(.footnote)
      Text("Caption")
        .font(.caption)
      Text("Caption 2")
        .font(.caption2)
    }
    .padding()
  }
}

struct CustomFontView: View {
  var body: some View {
    Text("Custom Font Example")
      .font(.custom("Futura-Medium", size: 20))
      .scaledToFill()
      .font(.title)
      .minimumScaleFactor(0.5)
      .padding()
  }
}

struct AdaptiveLayoutView: View {
  var body: some View {
    VStack {
      Text("This is a title")
        .font(.title)
        .padding()

      Text("This is a longer body text that demonstrates how text wrapping works when the font size increases. Make sure to test with different text sizes.")
        .font(.body)
        .padding()
    }
    .padding()
  }
}

struct AccessibleView: View {
  var body: some View {
    VStack {
      Text("Welcome to our app!")
        .font(.title)
        .accessibilityLabel("Welcome message")
        .accessibilityHint("Displays a welcome message to the user.")
        .padding()

      Button(action: {
        // Action
      }) {
        Text("Continue")
          .font(.headline)
      }
      .accessibilityLabel("Continue button")
      .accessibilityHint("Tap to proceed to the next screen.")
      .padding()
    }
  }
}

struct GroupedView: View {
  var body: some View {
    HStack {
      Image(systemName: "star.fill")
      Text("Favorite")
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel("Favorite star")
    .accessibilityHint("Indicates this item is a favorite.")
  }
}

struct CustomActionView: View {
  var body: some View {
    Button(action: {
      // Action
    }) {
      Text("Custom Action")
        .font(.headline)
    }
    .accessibilityAction(named: "Perform custom action") {
      // Perform custom action
    }
  }
}

struct AccessibleForm: View {
  @State private var name: String = ""

  var body: some View {
    Form {
      TextField("Name", text: $name)
        .accessibilityLabel("Name input field")
        .accessibilityHint("Enter your full name.")
        .accessibilityValue(name)
    }
  }
}
