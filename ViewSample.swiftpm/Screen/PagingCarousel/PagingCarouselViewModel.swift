import SwiftUI
import Combine

// MARK: - Dependency
final class PagingCarouselDependency: DynamicProperty {
    var timerRepository = CarouselTimerRepository()
}

// MARK: - ViewModel
final class PagingCarouselViewModel: ObservableObject {
    let dependency: PagingCarouselDependency
    let input: Input
    let output: Output
    @ObservedObject var binding: Binding
    
    var cancellables = Set<AnyCancellable>()
    
    init(
        dependency: PagingCarouselDependency = .init(),
        input: Input = .init(),
        output: Output = .init(),
        binding: Binding = .init()
    ) {
        self.dependency = dependency
        self.input = input
        self.output = output
        self.binding = binding
        
        bind(dependency: dependency,
             input: input,
             output: output,
             binding: binding)
    }
}

// MARK: - Property
extension PagingCarouselViewModel {
    
    final class Input {
        let didAppear = PassthroughSubject<(), Never>()
        let didDisappear = PassthroughSubject<(), Never>()
        let didTapItem = PassthroughSubject<CarouselItemModel, Never>()
        let didScroll = PassthroughSubject<CGFloat, Never>()
        let didEndScroll = PassthroughSubject<CGFloat, Never>()
    }
    
    final class Output: ObservableObject {
        let models: [CarouselItemModel] = CarouselItemModel.stub
    }
    
    final class Binding: ObservableObject {
        @Published var scrollIndex: Int = 0
        @Published var scrollOffset: CGFloat = 0
        @Published var scrollTimerEnabled: Bool = false
    }
}

// MARK: - Private
private extension PagingCarouselViewModel {
    
    func bind(
        dependency: PagingCarouselDependency,
        input: Input,
        output: Output,
        binding: Binding
    ) {
        binding
            .objectWillChange
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        input.didAppear
            .filter { binding.scrollTimerEnabled }
            .sink { 
                dependency.timerRepository.set() 
            }
            .store(in: &cancellables)
        
        input.didDisappear
            .filter { binding.scrollTimerEnabled }
            .sink { 
                binding.scrollTimerEnabled = false
                dependency.timerRepository.cancel()
            }
            .store(in: &cancellables)
        
        input.didTapItem
            .sink { debugPrint("tap: \($0.id)") }
            .store(in: &cancellables)
        
        input.didScroll
            .map { $0 - CarouselItemModel.totalWidth * CGFloat(binding.scrollIndex) }
            .assign(to: \.scrollOffset, on: binding)
            .store(in: &cancellables)
        
        input.didEndScroll
            .map { point -> Int in
                switch CarouselItemModel.totalWidth / 2 {
                case let line where line < -point:
                    return min(binding.scrollIndex + 1, output.models.endIndex - 1)
                    
                case let line where line < point:
                    return max(binding.scrollIndex - 1, 0)
                    
                default: 
                    return binding.scrollIndex
                }
            }
            .assign(to: \.scrollIndex, on: binding)
            .store(in: &cancellables)
        
        binding.$scrollIndex
            .map { -CarouselItemModel.totalWidth * CGFloat($0) }
            .sink { offset in
                withAnimation {
                    binding.scrollOffset = offset
                }
            }
            .store(in: &cancellables)
        
        binding.$scrollTimerEnabled
            .filter { $0 }
            .sink { _ in dependency.timerRepository.set() }
            .store(in: &cancellables)
        
        dependency.timerRepository.timer
            .filter { binding.scrollTimerEnabled }
            .filter { !output.models.isEmpty }
            .map {
                guard binding.scrollIndex < output.models.count-1 else { return 0 }
                return binding.scrollIndex + 1
            }
            .assign(to: \.scrollIndex, on: binding)
            .store(in: &cancellables)
    }
}
