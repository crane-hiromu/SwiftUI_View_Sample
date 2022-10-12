import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab, paging, carousel, rectangle
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        case .paging: return "Paging Sample"
        case .carousel: return "Carousel Sample"
        case .rectangle: return "Variable Rectangle Sample"
        }
    }
    
    var destination: some View {
        switch self {
        case .tab: return TabWrapperView()
        case .paging: return PagingView()
        case .carousel: return CarouselWrapperView(viewModel: .init())
        case .rectangle: return WhiteLayer{ RectangleWrapperView() }
        }
    }
}

