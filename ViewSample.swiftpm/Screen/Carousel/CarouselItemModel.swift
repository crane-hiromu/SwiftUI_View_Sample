import SwiftUI

// MARK: - Model
final class CarouselItemModel {
    static let itemWidth: CGFloat = 320
    static let itemSpacing: CGFloat = 8.0
    static let totalWidth: CGFloat = itemWidth + itemSpacing
    static func padding(size: CGSize) -> CGFloat {
        (size.width - itemWidth) / 2
    }
    
    var id: Int = UUID().hashValue
    var imageUrl: URL? = nil
    var url: URL = URL(string: "https://www.google.com/")!
    var openWithExternalBrowser: Bool = false
    
    static let stub: [CarouselItemModel] = [
        .init(), .init(), .init(), .init(), .init()
    ]
}
