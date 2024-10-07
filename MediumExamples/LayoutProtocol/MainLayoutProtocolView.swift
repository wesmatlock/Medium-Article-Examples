

import SwiftUI

struct MainLayoutProtocolView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Flow Layout", destination: FlowLayoutView())
        NavigationLink("Circular Layout", destination: CircularLayoutView())
      }
    }
    .navigationTitle("Layout Protocol Views")

  }
}

#Preview {
  MainLayoutProtocolView()
}
