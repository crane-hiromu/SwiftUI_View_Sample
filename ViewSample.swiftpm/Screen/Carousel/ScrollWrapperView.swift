import SwiftUI

// MARK: - View
struct ScrollWrapperView<Content: View>: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    @ViewBuilder var content: Content
    let onChangeOffset: (CGPoint) -> Void
    
    init(
        _ axes: Axis.Set = .vertical, 
        showsIndicators: Bool = true,
        @ViewBuilder content: () -> Content,
        onChangeOffset: @escaping (CGPoint) -> Void
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content()
        self.onChangeOffset = onChangeOffset
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators, content: {
            content.onChangeParentScrollViewOffset(perform: onChangeOffset)
        })
    }
}

// MARK: - Key
struct ScrollViewOffsetKey: PreferenceKey, ClassNameProtocol {
    static var defaultValue = CGPoint.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        // update value
        value.x += nextValue().x
        value.y += nextValue().y
        // reverse value
        value.x = -value.x
        value.y = -value.y
    }
}

// MARK: - Extension
private extension View {
    
    func onChangeParentScrollViewOffset(perform: @escaping (CGPoint) -> Void) -> some View {
        self
            .background(GeometryReader {
                Color.clear.preference(
                    key: ScrollViewOffsetKey.self, 
                    value: $0.frame(in: .named(ScrollViewOffsetKey.className)).origin
                )
            })
            .onPreferenceChange(
                ScrollViewOffsetKey.self,
                perform: perform
            )
    }
}
