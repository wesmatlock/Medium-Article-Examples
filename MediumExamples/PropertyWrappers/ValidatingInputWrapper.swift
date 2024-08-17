import Foundation

enum ValidationError: Error {
  case invalidEmail
}

@propertyWrapper
struct ValidatedEmail {
  private var value: String

  init(wrappedValue: String) {
    if ValidatedEmail.isValidEmail(wrappedValue) {
      self.value = wrappedValue
    } else {
      print("Invalid email provided during initialization. Setting default value.")
      self.value = "invalid@example.com" // Default value in case of invalid email
    }
  }

  var wrappedValue: String {
    get { value }
    set {
      if ValidatedEmail.isValidEmail(newValue) {
        value = newValue
      } else {
        print("Invalid email address")
      }
    }
  }

  static func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
  }
}

struct User {
  @ValidatedEmail var email: String

  init(email: String) {
    self._email = ValidatedEmail(wrappedValue: email)
  }
}

struct ValidExample {
  func checkEmail() {
    // Example of usage
    var user = User(email: "example@domain.com")
    print("User email: \(user.email)")  // Output: User email: example@domain.com

    // Attempting to update with a valid email
    user.email = "new.email@domain.com"
    print("Updated email: \(user.email)")  // Output: Updated email: new.email@domain.com

    // Attempting to update with an invalid email
    user.email = "invalid-email"
    print("After invalid update, email: \(user.email)")  // Output: Invalid email address
  }
}
