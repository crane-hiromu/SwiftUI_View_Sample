import SwiftUI
import Combine

struct CarouselWrapperView: View {
    @ObservedObject var viewModel: CarouselWrapperViewModel
    
    var body: some View {
        GeometryReader { proxy in
            CarouselView(
                size: proxy.size, 
                models: CarouselItemModel.stub, 
                scrollIndex: viewModel.$binding.scrollIndex,
                didTapItem: { _ in },
                didChangeOffset: { viewModel.input.didChangeOffset.send($0) }
            )
        }
        
    }
}

// MARK: - View
struct CarouselView: View {
    private let itemWidth: CGFloat = 320
    private var padding: CGFloat {
        (size.width - itemWidth) / 2
    }
    
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
            .frame(height: itemWidth)
            .padding(.bottom, 54)
            .onReceive(Just(scrollIndex)) { index in
                guard !models.isEmpty else { return }
                withAnimation {
                    proxy.scrollTo(models[index].id, anchor: .center)
                }
            }
        }
    }
    
    private var bannerCollection: some View {
        HStack {
            LazyHStack(spacing: 8) {
                ForEach(models, id: \.id) { model in
                    CarouselItem(
                        width: itemWidth, 
                        model: model,
                        didTap: { didTapItem(model) }
                    ).id(model.id)
                }
            }
            .padding([.leading, .trailing], padding)
        }
    }
}

// MARK: - Item
private struct CarouselItem: View {
    let width: CGFloat
    let model: CarouselItemModel
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
            Image("320x320")
                .resizable()
                .frame(width: width, height: width)
        }
    }
}

// MARK: - Model
final class CarouselItemModel {
    var id: Int = UUID().hashValue
    var imageUrl: URL? = nil
    
    static let stub: [CarouselItemModel] = [
        .init(), .init(), .init(), .init(), .init()
    ]
}

