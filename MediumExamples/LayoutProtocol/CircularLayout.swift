import SwiftUI

struct CircularLayout: Layout {
  struct CacheData {
    var positions: [CGPoint] = []
    var itemSize: CGSize = .zero
  }

  typealias Cache = CacheData

  func makeCache(subviews: Subviews) -> Cache {
    return CacheData()
  }

  func updateCache(_ cache: inout Cache, subviews: Subviews) {
    // For this layout, we can leave it empty or remove this method if not needed
  }

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
    let diameter = min(proposal.width ?? 200, proposal.height ?? 200)
    let radius = diameter / 2
    let center = CGPoint(x: radius, y: radius)
    let angleIncrement = (2 * CGFloat.pi) / CGFloat(subviews.count)

    cache.positions = []
    cache.itemSize = CGSize(width: diameter / 4, height: diameter / 4) // Arbitrary item size

    for index in subviews.indices {
      let angle = angleIncrement * CGFloat(index)
      let x = center.x + radius * cos(angle) - cache.itemSize.width / 2
      let y = center.y + radius * sin(angle) - cache.itemSize.height / 2
      cache.positions.append(CGPoint(x: x, y: y))
    }

    return CGSize(width: diameter, height: diameter)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
    for index in subviews.indices {
      let position = cache.positions[index]
      subviews[index].place(
        at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
        proposal: ProposedViewSize(cache.itemSize)
      )
    }
  }
}
