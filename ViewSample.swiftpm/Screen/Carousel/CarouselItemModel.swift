import SwiftUI

// MARK: - Model
final class CarouselItemModel {
    static let itemWidth: CGFloat = 320
    static let itemSpacing: CGFloat = 8.0
    static let totalWidth: CGFloat = itemWidth + totalWidth
    static func padding(size: CGSize) -> CGFloat {
        (size.width - itemWidth) / 2
    }
    
    var id: Int = UUID().hashValue
    var imageUrl: URL? = nil
    
    static let stub: [CarouselItemModel] = [
        .init(), .init(), .init()
    ]
}
