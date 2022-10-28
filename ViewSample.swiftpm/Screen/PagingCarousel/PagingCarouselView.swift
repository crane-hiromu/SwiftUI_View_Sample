import SwiftUI

// MARK: - Wrapper View
struct PagingCarouselWarapperView: View {
    @ObservedObject var viewModel: PagingCarouselViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack {
                    PagingCarouselView(
                        size: proxy.size,
                        models: viewModel.output.models,
                        scrollIndex: viewModel.$binding.scrollIndex,
                        scrollOffset: viewModel.$binding.scrollOffset,
                        didTapItem: { viewModel.input.didTapItem.send($0) },
                        didScroll: { viewModel.input.didScroll.send($0) },
                        didEndScroll: { viewModel.input.didEndScroll.send($0) }
                    )
                    .onAppear { viewModel.input.didAppear.send(()) }
                    .onDisappear { viewModel.input.didDisappear.send(()) }
                    
                    Toggle("Auto swipe enabled (4 sec): ", isOn: viewModel.$binding.scrollTimerEnabled)
                        .frame(width: CarouselItemModel.itemWidth)
                }
            }
        }
    }
}

// MARK: - View
struct PagingCarouselView: View {
    let size: CGSize
    let models: [CarouselItemModel]
    @Binding var scrollIndex: Int
    @Binding var scrollOffset: CGFloat
    
    let didTapItem: (CarouselItemModel) -> Void
    let didScroll: (CGFloat) -> Void
    let didEndScroll: (CGFloat) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) { collection }
            .content.offset(x: scrollOffset)
            .frame(width: size.width, height: CarouselItemModel.itemWidth, alignment: .leading)
            .simultaneousGesture(dragGestures)
    }
    
    private var collection: some View {
        HStack(spacing: CarouselItemModel.itemSpacing) {
            ForEach(models, id: \.id) { model in
                PagingCarouselItem(
                    model: model, 
                    didTap: { didTapItem(model) }
                )
            }
        }
        .padding([.leading, .trailing], CarouselItemModel.padding(size: size))
    }
    
    private var dragGestures: some Gesture {
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
        HighlightButton(didTap: didTap) {
            Image("320x320")
                .resizable()
                .frame(
                    width: CarouselItemModel.itemWidth,
                    height: CarouselItemModel.itemWidth
                )
        }
    }
}
