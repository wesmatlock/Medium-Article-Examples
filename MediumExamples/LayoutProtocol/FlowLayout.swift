import SwiftUI

struct FlowLayout: Layout {

  var spacing: CGFloat = 8

  struct CacheData {
    var sizes: [CGSize] = []
    var positions: [CGPoint] = []
  }

  typealias Cache = CacheData

  func makeCache(subviews: Subviews) -> CacheData {
    CacheData()
  }

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
    var currentX: CGFloat = 0
    var currentY: CGFloat = 0
    var lineHeight: CGFloat = 0
    let maxWidth = proposal.width ?? .infinity

    cache.sizes = []
    cache.positions = []

    for subview in subviews {
      let subviewSize = subview.sizeThatFits(.unspecified)
      if currentX + subviewSize.width > maxWidth {
        currentX = 0
        currentY += lineHeight + spacing
        lineHeight = 0
      }

      cache.positions.append(CGPoint(x: currentX, y: currentY))
      cache.sizes.append(subviewSize)

      currentX += subviewSize.width + spacing
      lineHeight = max(lineHeight, subviewSize.height)
    }

    return CGSize(width: maxWidth, height: currentY + lineHeight)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
    for index in subviews.indices {
      let position = cache.positions[index]
      let size = cache.sizes[index]
      subviews[index].place(
        at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
        proposal: ProposedViewSize(width: size.width, height: size.height)
      )
    }
  }
}
