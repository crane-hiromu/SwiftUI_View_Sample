import SwiftUI
import Combine

// MARK: - ViewModel
final class PagingCarouselViewModel: ObservableObject {
    @Published var scrollIndex: Int = 0
    @Published var scrollOffset: CGFloat = 0
    let models: [CarouselItemModel] = CarouselItemModel.stub
    
    var timerRepository = CarouselTimerRepository()
    var cancellables = Set<AnyCancellable>()
    var totalWidth: CGFloat { 
        CarouselItemModel.itemWidth + CarouselItemModel.itemSpacing 
    }
    
    let didScroll = PassthroughSubject<CGFloat, Never>()
    let didEndScroll = PassthroughSubject<CGFloat, Never>()
    
    init() {
        didScroll
            .map { $0 - self.totalWidth * CGFloat(self.scrollIndex) }
            .assign(to: \.scrollOffset, on: self)
            .store(in: &cancellables)
        
        didEndScroll
            .subscribe(on: DispatchQueue.global())
            .map { point -> Int in
                switch self.totalWidth / 2 {
                case let line where line < -point:
                    return min(self.scrollIndex + 1, self.models.endIndex - 1)
                    
                case let line where line < point:
                    return max(self.scrollIndex - 1, 0)
                    
                default: 
                    return self.scrollIndex
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.scrollIndex, on: self)
            .store(in: &cancellables)
        
        $scrollIndex
            .map { -self.totalWidth * CGFloat($0) }
            .sink { offset in
                withAnimation {
                    self.scrollOffset = offset
                }
            }
            .store(in: &cancellables)
        
        timerRepository.timer
            .dropFirst()
            .filter { !self.models.isEmpty }
            .map {
                guard self.scrollIndex < self.models.count-1 else { return 0 }
                return self.scrollIndex + 1
            }
            .assign(to: \.scrollIndex, on: self)
            .store(in: &cancellables)
        
        timerRepository.set()
    }
}
