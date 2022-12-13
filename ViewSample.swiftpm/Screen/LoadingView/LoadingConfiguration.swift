import SwiftUI

// MARK: - Configuration
final class LoadingConfiguration: ObservableObject {
    /// Loading State
    @Published var enabled: Bool = false
    @Published var showsProgress: Bool = true
    
    /// Animation Setting
    @Published var animation: Animation = .easeInOut
    
    /// Filter Setting
    @Published var filterColor: Color = .white
    @Published var filterOpacity: Double = 0.6
    
    /// Loading Progress & Image Setting
    @Published var progressColor: Color  = .white
    @Published var progressImageSize: CGSize = .init(width: 24, height: 24)
    @Published var progressImageMode: ContentMode = .fit
    
    /// Loading Title Setting
    @Published var title: String? = nil
    @Published var titleFont: Font? = .title3
    
    /// Loading View Setting
    @Published var backgroundColor: Color = Color.black.opacity(0.7)
    @Published var padding: CGFloat = 28.0
    @Published var cornerRadius: CGFloat = 16.0
}

extension LoadingConfiguration {
    
    var progressBottomPadding: CGFloat {
        title.isNilOrEmpty ? 0.0 : 16.0
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        guard let self = self else { return true }
        return self.isEmpty
    }
}
