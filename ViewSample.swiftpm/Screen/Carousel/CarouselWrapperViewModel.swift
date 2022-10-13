import SwiftUI
import Combine

// MARK: - ViewModel
final class CarouselWrapperViewModel: ObservableObject {
    var store: Store
    var input: Input
    var output: Output
    @ObservedObject var binding: Binding
    
    var timerRepository = CarouselTimerRepository()
    
    init(
        input: Input = .init(),
        output: Output = .init(), 
        binding: Binding = .init(),
        store: Store = .init()
    ) {
        self.input = input
        self.output = output
        self.binding = binding
        self.store = store
        
        bind(input: input,
             output: output,
             binding: binding,
             store: store)
    }
}

extension CarouselWrapperViewModel {
    
    final class Input {
        let didChangeOffset = PassthroughSubject<CGPoint, Never>()
    }
    
    final class Output: ObservableObject {
        @Published var models: [CarouselItemModel] = CarouselItemModel.stub
    }
    
    final class Binding: ObservableObject {
        @Published var scrollIndex: Int = 0
    }
    
    final class Store {
        var cancellables = Set<AnyCancellable>()
        var offset: CGPoint = .zero
        var index: Int { Int(floor(offset.x / (320 + 8))) } // width + spacing
    }
}

extension CarouselWrapperViewModel {
    
    func bind(
        input: Input,
        output: Output, 
        binding: Binding,
        store: Store
    ) {
        binding
            .objectWillChange
            .sink { [weak self] _ in 
                self?.objectWillChange.send() 
            }
            .store(in: &store.cancellables)
        
        input
            .didChangeOffset
            .assign(to: \.offset, on: store)
            .store(in: &store.cancellables)
        
        timerRepository.timer
            .dropFirst()
            .filter { !output.models.isEmpty }
            .map {
                guard binding.scrollIndex < output.models.count-1 else { return 0 }
                return store.index + 1
            }
            .assign(to: \.scrollIndex, on: binding)
            .store(in: &store.cancellables)
        
        timerRepository.set()
    }
}
