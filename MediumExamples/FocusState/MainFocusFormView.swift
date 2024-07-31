import SwiftUI
#if os(iOS)
struct MainFocusFormView: View {
  @State private var formState = FormState()
  @FocusState private var focusField: FormField?

  var body: some View {
    VStack {
      Form {
        TextField("First Name", text: $formState.firstName)
          .focused($focusField, equals: .firstName)
          .onSubmit {
            focusField = .lastName
          }
          .submitLabel(.next)
        TextField("Last Name", text: $formState.lastName)
          .focused($focusField, equals: .lastName)
          .onSubmit {
            focusField = .email
          }
          .submitLabel(.next)
        TextField("Email", text: $formState.email)
          .focused($focusField, equals: .email)
          .onSubmit {
            focusField = .password
          }
          .submitLabel(.next)
        SecureField("Password", text: $formState.password)
          .focused($focusField, equals: .password)
          .onSubmit {
            focusField = .confirmPassword
          }
          .submitLabel(.next)
        SecureField("Confirm Password", text: $formState.confirmPassword)
          .focused($focusField, equals: .confirmPassword)
          .onSubmit {
            validateForm()
          }
          .submitLabel(.done)
      }
      .padding()

      Button("Submit") {
        validateForm()
      }
      .padding()
      .buttonStyle(.borderedProminent)
    }
    .onTapGesture {
      focusField = nil
    }
    .toolbar {
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("Done") {
          focusField = nil
        }
      }
    }
  }

  private func validateForm() {
    guard !formState.firstName.isEmpty,
          !formState.lastName.isEmpty,
          isValidateEmail(formState.email),
          formState.password == formState.confirmPassword else {
      // Handle error
      return
    }
    // do something with the data
    print("Form Submitted: \(formState)")
    focusField = nil
  }

  private func isValidateEmail(_ email: String) -> Bool {
    // Basic email validation logic
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)  }
}



// MARK: - FormField and State
enum FormField: Hashable {
  case firstName
  case lastName
  case email
  case password
  case confirmPassword
}

struct FormState {
  var firstName: String = ""
  var lastName: String = ""
  var email: String = ""
  var password: String = ""
  var confirmPassword: String = ""
}

// MARK: - Preview
#Preview {
  MainFocusFormView()
}
#endif
