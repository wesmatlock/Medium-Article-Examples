import SwiftUI

struct MyPreferenceKey: PreferenceKey {
  static var defaultValue: String = ""

  static func reduce(value: inout String, nextValue: () -> String) {
    value = nextValue()
  }
}
