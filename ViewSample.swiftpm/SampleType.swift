import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab, paging, carousel, pagingCarousel, rectangle, highlightButton, inputTag
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        case .paging: return "Paging Sample"
        case .carousel: return "Carousel Sample"
        case .pagingCarousel: return "Paging Carousel Sample"
        case .rectangle: return "Variable Rectangle Sample"
        case .highlightButton: return "Highlight Button"
        case .inputTag: return "Custom Keyboard toolbar"
        }
    }
    
    var destination: some View {
        Group {
            switch self {
            case .tab: 
                TabWrapperView()
            case .paging: 
                PagingView()
            case .carousel: 
                CarouselWrapperView(viewModel: .init())
            case .pagingCarousel: 
                PagingCarouselWarapperView(viewModel: .init())
            case .rectangle: 
                WhiteLayer{ RectangleWrapperView() }
            case .highlightButton: 
                HighlightButton(didTap: {}) { Rectangle().frame(width: 300, height: 100) }
            case .inputTag: 
                let tags = ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8"]
                InputTagView(viewModel: .init(binding: .init(tags: tags))).frame(width: 375, height: 50)
            }
        }
    }
}
