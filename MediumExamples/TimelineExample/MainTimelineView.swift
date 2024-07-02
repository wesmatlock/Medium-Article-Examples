import SwiftUI

struct MainTimelineView: View {
  var body: some View {
//    ClockView()
    CountdownTimerView(endDate: Date().addingTimeInterval(300))
  }
}
// MARK: - ClockView
struct ClockView: View {
  var body: some View {
    TimelineView(.animation(minimumInterval: 1.0, paused: false)) { context in
      let date = context.date
      VStack {
        Text(dateFormatter.string(from: date))
          .font(.largeTitle)
          .padding()
        Text(dateOnlyFormatter.string(from: date))
          .font(.title)
          .padding()
      }
    }
  }

  private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
  }

  private var dateOnlyFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
  }
}

// MARK: - CountdownTimerView
struct CountdownTimerView: View {
  let endDate: Date

  var body: some View {
    TimelineView(.periodic(from: Date(), by: 1.0)) { context in
      let currentDate = context.date
      let remainingTime = endDate.timeIntervalSince(currentDate)
      let minutes = Int(remainingTime) / 60
      let seconds = Int(remainingTime) % 60

      VStack {
        Text(String(format: "%02d:%02d", minutes, seconds))
          .font(.largeTitle)
          .padding()
      }
    }
  }
}

#Preview {
  MainTimelineView()
}
