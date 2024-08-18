import SwiftUI

struct CameraScanView: View {
  @State private var creditCardNumber: String = ""

  var body: some View {
    ZStack {
      CreditCardScannerView { cardNumber in
        self.creditCardNumber = cardNumber
      }
      .edgesIgnoringSafeArea(.all)

      if !creditCardNumber.isEmpty {
        Text("Detected Credit Card Number: \(creditCardNumber)")
          .padding()
          .background(Color.white)
          .foregroundStyle(.black)
          .cornerRadius(10)
          .shadow(radius: 10)
          .padding()
      }
    }
  }
}
