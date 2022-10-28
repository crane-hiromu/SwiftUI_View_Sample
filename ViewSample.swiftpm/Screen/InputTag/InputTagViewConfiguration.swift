import SwiftUI

// MARK: - Configuration
final class InputTagViewConfiguration: ObservableObject {
    
    /// View Configuration
    let horizontalPadding: CGFloat
    let showsIndicators: Bool
    
    /// Tag Configuration
    let tagColor: Color
    let tagCollectionHeight: CGFloat
    let tagSpacing: CGFloat
    let tagCornerRadius: CGFloat
    let tagLineWidth: CGFloat
    let tagVerticalPadding: CGFloat
    let tagHorizontalPadding: CGFloat
    
    /// Button Configuration
    let buttonColor: Color
    let buttonTitle: String
    
    init(
        horizontalPadding: CGFloat = 16.0,
        showsIndicators: Bool = false,
        tagColor: Color = .gray,
        tagCollectionHeight: CGFloat = 40.0,
        tagSpacing: CGFloat = 8,
        tagCornerRadius: CGFloat = 12.0,
        tagLineWidth: CGFloat = 1.0,
        tagVerticalPadding: CGFloat = 2.0,
        tagHorizontalPadding: CGFloat = 8.0,
        buttonColor: Color = .accentColor,
        buttonTitle: String = "完了"
    ) {
        self.horizontalPadding = horizontalPadding
        self.showsIndicators = showsIndicators
        self.tagCollectionHeight = tagCollectionHeight
        self.tagSpacing = tagSpacing
        self.tagColor = tagColor
        self.tagCornerRadius = tagCornerRadius
        self.tagLineWidth = tagLineWidth
        self.tagVerticalPadding = tagVerticalPadding
        self.tagHorizontalPadding = tagHorizontalPadding
        self.buttonColor = buttonColor
        self.buttonTitle = buttonTitle
    }
}
