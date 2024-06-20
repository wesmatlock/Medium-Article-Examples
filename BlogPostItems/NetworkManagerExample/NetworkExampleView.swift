import SwiftUI

struct NetworkExampleView: View {
  @State private var viewModel = NetworkExampleViewModel()
  var body: some View {
    List(viewModel.data) { item in
      Text(item.name)
    }
    .task {
      await viewModel.fetchData()
    }
  }
}

#Preview {
  NetworkExampleView()
}
