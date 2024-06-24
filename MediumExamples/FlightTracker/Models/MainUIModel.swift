import SwiftUI


final class MainUIModel: ObservableObject {
  @Published var selectedDetent: PresentationDetent = .height(200)
}
