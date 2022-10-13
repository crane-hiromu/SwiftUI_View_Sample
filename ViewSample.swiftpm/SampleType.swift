import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab, paging, carousel, pagingCarousel, rectangle
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        case .paging: return "Paging Sample"
        case .carousel: return "Carousel Sample"
        case .pagingCarousel: return "Paging Carousel Sample"
        case .rectangle: return "Variable Rectangle Sample"
        }
    }
    
    var destination: some View {
        Group {
            switch self {
            case .tab: TabWrapperView()
            case .paging: PagingView()
            case .carousel: CarouselWrapperView(viewModel: .init())
            case .pagingCarousel: PagingCarouselWarapperView(viewModel: .init())
            case .rectangle: WhiteLayer{ RectangleWrapperView() }
            }
        }
    }
}
