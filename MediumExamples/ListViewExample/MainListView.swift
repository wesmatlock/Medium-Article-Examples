import SwiftUI
import SwiftData

struct MainListView: View {
  var body: some View {
      TabView {
        SimpleListView()
          .tabItem {
            Label("Simple List", systemImage: "list.bullet")
          }
        CustomRowListView()
          .tabItem {
            Label("Custom Rows", systemImage: "rectangle.3.offgrid")
          }
        SectionedListView()
          .tabItem {
            Label("Sections", systemImage: "square.stack.3d.up")
          }
        SwipeActionListView()
          .tabItem {
            Label("Swipe Actions", systemImage: "hand.point.right")
          }
        ReorderableListView()
          .tabItem {
            Label("Reorder", systemImage: "arrow.up.arrow.down")
          }
        SearchableListView()
          .tabItem {
            Label("Search", systemImage: "magnifyingglass")
          }
      }
    }
}

#Preview {
  MainListView()
}

struct SimpleListView: View {
  let items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

  var body: some View {
    List(items, id: \.self) { item in
      Text(item)
    }
  }
}

struct CustomRowListView: View {
  let items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

  var body: some View {
    List(items, id: \.self) { item in
      HStack {
        Image(systemName: "leaf")
          .foregroundColor(.green)
        Text(item)
          .font(.headline)
        Spacer()
        Button(action: {
          print("\(item) selected")
        }) {
          Image(systemName: "info.circle")
        }
      }
    }
  }
}

struct SectionedListView: View {
  let fruits = ["Apple", "Banana", "Cherry"]
  let vegetables = ["Carrot", "Lettuce", "Tomato"]

  var body: some View {
    List {
      Section(header: Text("Fruits")) {
        ForEach(fruits, id: \.self) { item in
          Text(item)
        }
      }
      Section(header: Text("Vegetables")) {
        ForEach(vegetables, id: \.self) { item in
          Text(item)
        }
      }
    }
  }
}

struct SwipeActionListView: View {
  @State private var items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

  var body: some View {
    List {
      ForEach(items, id: \.self) { item in
        Text(item)
          .swipeActions {
            Button(role: .destructive) {
              if let index = items.firstIndex(of: item) {
                items.remove(at: index)
              }
            } label: {
              Label("Delete", systemImage: "trash")
            }
          }
      }
    }
  }
}

struct ReorderableListView: View {
  @State private var items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

  var body: some View {
    NavigationView {
      List {
        ForEach(items, id: \.self) { item in
          HStack {
            Text(item)
          }
        }
        .onMove(perform: move)
      }
      .toolbar {
        EditButton()
      }
      .navigationTitle("Reorderable List")
    }
  }

  func move(from source: IndexSet, to destination: Int) {
    print("source: \(source)  =  destination:\(destination)")
    items.move(fromOffsets: source, toOffset: destination)
  }
}
//struct ReorderableListView: View {
//  @State private var items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]
//
//  var body: some View {
//    List {
//      ForEach(items, id: \.self) { item in
//        Text(item)
//      }
//      .onMove(perform: move)
//    }
//    .toolbar {
//      EditButton()
//    }
//  }
//
//  func move(from source: IndexSet, to destination: Int) {
//    items.move(fromOffsets: source, toOffset: destination)
//  }
//}

struct SearchableListView: View {
  @State private var searchText = ""
  let items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

  var filteredItems: [String] {
    if searchText.isEmpty {
      return items
    } else {
      return items.filter { $0.contains(searchText) }
    }
  }

  var body: some View {
    List(filteredItems, id: \.self) { item in
      Text(item)
    }
    .searchable(text: $searchText)
  }
}

//struct SwiftDataListView: View {
//  @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)])
//  var items: FetchedResults<Item>
//
//  var body: some View {
//    List {
//      ForEach(items) { item in
//        Text(item.name ?? "Unknown")
//      }
//    }
//  }
//}
