import SwiftUI

struct MainWalkingRoute: View {
    var body: some View {
      RoutesMapView()
      .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MainWalkingRoute()
}
