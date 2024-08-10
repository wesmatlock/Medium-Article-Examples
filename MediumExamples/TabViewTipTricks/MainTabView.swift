import SwiftUI

struct MainTabView: View {
  @StateObject private var appState = AppState()

  var body: some View {
//    FirstView()
//    SecondView()
//    ColorTabView()
//    SelectableTabView()
    CustomTabView()
    //    CustomTabView()
//    AdvancedTabView()
//      .environmentObject(appState)
  }
}

#Preview {
  MainTabView()
}

struct FirstView: View {
  var body: some View {
    TabView {
      Text("Home")
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
      Text("Settings")
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
  }
}

struct SecondView: View {
  var body: some View {
    TabView {
      Text("Home")
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
      Text("Settings")
        .tabItem {
          Image(systemName: "gearshape.fill")
          Text("Settings")
        }
    }
  }
}

struct ColorTabView: View {
  init() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemMint

    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }

  var body: some View {
    TabView {
      Text("Home")
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
      Text("Settings")
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
  }
}

struct SelectableTabView: View {
  @State private var selectedTab = 0

  var body: some View {
    TabView(selection: $selectedTab) {
      Text("Home")
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
        .tag(0)

      Text("Settings")
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
        .tag(1)
    }
  }
}

struct CustomTabView: View {
  @State private var selectedTab = 0

  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        Text("Home")
          .tabItem { EmptyView() }
          .tag(0)
        Text("Settings")
          .tabItem { EmptyView() }
          .tag(1)
      }

      VStack {
        Spacer()
        HStack {
          Spacer()
          CustomTabBarItem(image: "house", selected: $selectedTab, index: 0)
          Spacer()
          CustomTabBarItem(image: "gear", selected: $selectedTab, index: 1)
          Spacer()
        }
        .padding(.bottom, 10)
      }
    }
  }
}

struct CustomTabBarItem: View {
  let image: String
  @Binding var selected: Int
  let index: Int

  var body: some View {
    Button(action: {
      selected = index
    }) {
      Image(systemName: image)
        .foregroundColor(selected == index ? .blue : .gray)
        .padding()
        .background(selected == index ? Color.white : Color.clear)
        .cornerRadius(10)
    }
  }
}
