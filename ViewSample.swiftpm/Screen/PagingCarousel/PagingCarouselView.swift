import SwiftUI

// MARK: - Wrapper View
struct PagingCarouselWarapperView: View {
    @ObservedObject var viewModel: PagingCarouselViewModel
    
    var body: some View {
        GeometryReader { proxy in
            PagingCarouselView(
                size: proxy.size,
                models: viewModel.models,
                scrollIndex: $viewModel.scrollIndex,
                scrollOffset: $viewModel.scrollOffset,
                didScroll: { viewModel.didScroll.send($0) },
                didEndScroll: { viewModel.didEndScroll.send($0) }
            )
        }
    }
}

// MARK: - View
struct PagingCarouselView: View {
    
    private var padding: CGFloat {
        // カルーセル開始位置を中央寄せにする
        (size.width - CarouselItemModel.itemWidth) / 2
    }
    
    let size: CGSize
    let models: [CarouselItemModel]
    @Binding var scrollIndex: Int
    @Binding var scrollOffset: CGFloat
    
    let didScroll: (CGFloat) -> Void
    let didEndScroll: (CGFloat) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) { collection }
                .content.offset(x: scrollOffset)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(gestures)
        }
    }
    
    private var collection: some View {
        LazyHStack(spacing: CarouselItemModel.itemSpacing) {
            ForEach(models, id: \.id) { model in
                PagingCarouselItem(
                    model: model,
                    didTap: { }
                )
            }
        }
        .padding([.leading, .trailing], padding)
    }
    
    private var gestures: some Gesture {
        DragGesture()
            .onChanged { didScroll($0.translation.width) }
            .onEnded { didEndScroll($0.predictedEndTranslation.width) }
    }
}

// MARK: - Item
private struct PagingCarouselItem: View {
    let model: CarouselItemModel
    let didTap: () -> Void
    
    var body: some View {
        Image("320x320")
            .resizable()
            .frame(
                width: CarouselItemModel.itemWidth,
                height: CarouselItemModel.itemWidth
            )
    }
}
