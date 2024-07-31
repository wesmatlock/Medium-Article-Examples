//
//  MainGestureView.swift
//  BlogPostItems
//
//  Created by Wesley Matlock on 7/5/24.
//

import SwiftUI

struct MainGestureView: View {
    var body: some View {
//      TapGestureView()
//      AnimatedTapView()
//      ConditionalTapView()
//      CustomGestureView()
//      InteractiveTapView()
//      SimultaneousGestureView()
      HighPriorityGestureView()
    }
}

// MARK: - Basic
struct TapGestureView: View {
  @State private var tapCount = 0

  var body: some View {
    Text("Tapped \(tapCount) times")
      .padding()
      .onTapGesture {
        tapCount += 1
      }
  }
}

// MARK: - Animated
struct AnimatedTapView: View {
  @State private var scale: CGFloat = 1.0

  var body: some View {
    Circle()
      .frame(width: 100, height: 100)
      .scaleEffect(scale)
      .onTapGesture {
        withAnimation(.spring()) {
          scale = scale == 1.0 ? 1.5 : 1.0
        }
      }
  }
}

// MARK: - Conditional
struct ConditionalTapView: View {
  @State private var tapCount = 0

  var body: some View {
    Text("Tapped \(tapCount) times")
      .padding()
      .onTapGesture {
        if tapCount < 5 {
          tapCount += 1
        } else {
          tapCount = 0
        }
      }
  }
}

// MARK: - Custom
struct CustomGestureView: View {
  @State private var color: Color = .blue

  var body: some View {
    Rectangle()
      .fill(color)
      .frame(width: 100, height: 100)
      .gesture(
        TapGesture(count: 2)
          .simultaneously(
            with: LongPressGesture(minimumDuration: 0.5)
          )
          .onEnded { _ in
            withAnimation {
              color = color == .blue ? .green : .blue
            }
          }
      )
  }
}

// MARK - Interactive
struct InteractiveTapView: View {
  @State private var tapped = false

  var body: some View {
    Text(tapped ? "Tapped!" : "Tap Me")
      .padding()
      .background(tapped ? Color.green : Color.red)
      .cornerRadius(8)
      .onTapGesture {
        withAnimation {
          tapped.toggle()
        }
      }
  }
}

// MARK: - Simulteneous
struct SimultaneousGestureView: View {
  @State private var tapCount = 0
  @State private var isLongPressed = false

  var body: some View {
    Text("Tapped \(tapCount) times")
      .padding()
      .background(isLongPressed ? Color.red : Color.blue)
      .simultaneousGesture(
        TapGesture()
          .onEnded {
            tapCount += 1
          }
      )
      .simultaneousGesture(
        LongPressGesture(minimumDuration: 1.0)
          .onEnded { _ in
            isLongPressed.toggle()
          }
      )
  }
}

// MARK: - Priority
struct HighPriorityGestureView: View {
  @State private var tapCount = 0
  @State private var isLongPressed = false

  var body: some View {
    Text("Tapped \(tapCount) times")
      .padding()
      .background(isLongPressed ? Color.red : Color.blue)
      .highPriorityGesture(
        LongPressGesture(minimumDuration: 1.0)
          .onEnded { _ in
            isLongPressed.toggle()
            tapCount = 0
          }
      )
      .onTapGesture {
        tapCount += 1
      }
  }
}

#Preview {
    MainGestureView()
}
