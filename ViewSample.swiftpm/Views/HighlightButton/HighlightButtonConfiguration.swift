import SwiftUI

// MARK: - Configuration
final class HighlightButtonConfiguration: ObservableObject {
    var defaultScaleRatio: CGFloat = 1.0
    var highlightedScaleRatio: CGFloat = 0.97
    var animation: Animation = .easeOut(duration: 0.3)
    
    init(
        defaultScaleRatio: CGFloat = 1.0,
        highlightedScaleRatio: CGFloat = 0.97,
        animation: Animation = .easeOut(duration: 0.3)
    ) {
        self.defaultScaleRatio = defaultScaleRatio
        self.highlightedScaleRatio = highlightedScaleRatio
        self.animation = animation
    }
}
