import SwiftUI

#if os(iOS)
struct CameraScanView: View {
  @State private var creditCardNumber: String = ""

  var body: some View {
    VStack {
      CreditCardScannerView { cardNumber in
        self.creditCardNumber = cardNumber
      }
      .edgesIgnoringSafeArea(.all)

      if !creditCardNumber.isEmpty {
        Text("Detected Credit Card Number: \(creditCardNumber)")
          .padding()
          .background(Color.white)
          .cornerRadius(10)
          .shadow(radius: 10)
          .padding()
      }
    }
  }
}
#endif
