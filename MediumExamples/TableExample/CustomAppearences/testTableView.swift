import SwiftUI

struct TableView: View {
  struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()

    var fullName: String { givenName + " " + familyName }
  }


  @State private var people = [
    Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
    Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
    Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
    Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
  ]

  var body: some View {
    Table(people) {
      TableColumn("Given Name", value: \.givenName)
      TableColumn("Family Name", value: \.familyName)
      TableColumn("E-Mail Address", value: \.emailAddress)
    }
  }
}
#Preview {
  TableView()
}
