import SwiftUI

struct MainDropmainMenu: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Basic Dropdown Menu", destination: BasicDropdownMenu())
        NavigationLink("Dropdown Menu Disclosure Group", destination: DropdownMenuDisclosureGroup())
//        NavigationLink("Advanced Dropdown Menu", destination: AdvancedDropdownMenu())
        NavigationLink("Animated Dropdown Menu", destination: AnimatedDropdownMenu())
        NavigationLink("Searchable Dropdown Menu", destination: SearchableDropdownMenu())
        NavigationLink("Multi-Select Dropdown Menu", destination: MultiSelectDropdownMenu())
      }
    }
  }
}

#Preview {
  MainDropmainMenu()
}
