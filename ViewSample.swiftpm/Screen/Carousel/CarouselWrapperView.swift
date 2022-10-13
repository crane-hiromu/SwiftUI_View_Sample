import SwiftUI
import Combine

struct CarouselWrapperView: View {
    @ObservedObject var viewModel: CarouselWrapperViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                CarouselView(
                    size: proxy.size, 
                    models: CarouselItemModel.stub, 
                    scrollIndex: viewModel.$binding.scrollIndex,
                    didTapItem: { _ in },
                    didChangeOffset: { viewModel.input.didChangeOffset.send($0) }
                )
                .onAppear { viewModel.input.didAppear.send(()) }
                .onDisappear { viewModel.input.didDisappear.send(()) }
                
                Toggle("Auto swipe enabled (4 sec): ", isOn: viewModel.$binding.scrollTimerEnabled)
                    .frame(width: CarouselItemModel.itemWidth)
            }
        }
    }
}

// MARK: - View
struct CarouselView: View {
    let size: CGSize
    let models: [CarouselItemModel]
    @Binding var scrollIndex: Int
    let didTapItem: (CarouselItemModel) -> Void
    let didChangeOffset: (CGPoint) -> Void
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollWrapperView(
                .horizontal, 
                showsIndicators: false,
                content: { bannerCollection },
                onChangeOffset: didChangeOffset
            )
            .frame(height: CarouselItemModel.itemWidth)
            .onReceive(Just(scrollIndex)) { index in
                guard index < models.count else { return }
                withAnimation {
                    proxy.scrollTo(models[index].id, anchor: .center)
                }
            }
        }
    }
    
    private var bannerCollection: some View {
        LazyHStack(spacing: CarouselItemModel.itemSpacing) {
            ForEach(models, id: \.id) { model in
                CarouselItem(
                    model: model,
                    didTap: { didTapItem(model) }
                ).id(model.id)
            }
        }
        .padding([.leading, .trailing], CarouselItemModel.padding(size: size))
    }
}

// MARK: - Item
private struct CarouselItem: View {
    let model: CarouselItemModel
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
            Image("320x320")
                .resizable()
                .frame(
                    width: CarouselItemModel.itemWidth,
                    height: CarouselItemModel.itemWidth
                )
        }
        .buttonStyle(LongPressHighlightStyle())
    }
}
