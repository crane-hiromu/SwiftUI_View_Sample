import SwiftUI

// MARK: - Button
struct HighlightButton<Content: View>: View {
    @State private var isPressed: Bool = false
    @ObservedObject var config: HighlightButtonConfiguration
    let didTap: () -> Void
    let content: Content
    
    var body: some View {
        content
            .scaleEffect(isPressed ? config.highlightedScaleRatio : config.defaultScaleRatio)
            .animation(config.animation, value: isPressed)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in didTap() }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { _ in 
                        guard !isPressed else { return }
                        isPressed = true 
                    }
                    .onEnded { _ in
                        isPressed = false 
                    }
            )
    }
    
    // MARK: Initializer
    
    init(
        config: HighlightButtonConfiguration = .init(),
        didTap: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.config = config
        self.didTap = didTap
        self.content = content()
    }
}
