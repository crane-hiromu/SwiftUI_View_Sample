import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab, carousel, rectangle
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        case .carousel: return "Carousel Sample"
        case .rectangle: return "Variable Rectangle Sample"
        }
    }
    
    var destination: some View {
        switch self {
        case .tab: return TabWrapperView()
        case .carousel: return CarouselWrapperView(viewModel: .init())
        case .rectangle: return WhiteLayer{ RectangleWrapperView() }
        }
    }
}

