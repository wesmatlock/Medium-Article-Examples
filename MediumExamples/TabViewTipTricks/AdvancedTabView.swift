import SwiftUI
import Combine

struct AdvancedTabView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
      SettingsView()
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
  }
}

struct HomeView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    VStack {
      Text("Welcome, \(appState.userName)")
      Button("Log Out") {
        appState.isLoggedIn = false
      }
    }
  }
}

struct SettingsView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    Form {
      TextField("User Name", text: $appState.userName)
      Toggle("Logged In", isOn: $appState.isLoggedIn)
    }
    .padding()
  }
}

#Preview {
  AdvancedTabView()
    .environmentObject(AppState())
}

class AppState: ObservableObject {
  @Published var isLoggedIn: Bool = false
  @Published var userName: String = ""
}

//struct ProfileView: View {
//  @StateObject private var profileViewModel = ProfileViewModel()
//  
//  var body: some View {
//    VStack {
//      Text("Profile")
//      // Use profileViewModel for local state management
//    }
//    .environmentObject(profileViewModel)
//  }
//}
//
//class ProfileViewModel: ObservableObject {
//  @Published var profile: Profile = Profile()
//}
