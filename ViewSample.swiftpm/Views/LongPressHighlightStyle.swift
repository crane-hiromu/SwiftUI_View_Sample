import SwiftUI

struct LongPressHighlightStyle: ButtonStyle {
    var defaultScaleRatio: CGFloat = 1.0
    var highlightedScaleRatio: CGFloat = 0.97
    var animation: Animation = .easeOut(duration: 0.3)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? highlightedScaleRatio : defaultScaleRatio)
            .animation(animation, value: configuration.isPressed)
    }
}
