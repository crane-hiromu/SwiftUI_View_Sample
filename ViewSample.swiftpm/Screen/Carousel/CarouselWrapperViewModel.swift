import SwiftUI
import Combine

// MARK: - Dependency
final class CarouselWrapperDependency: DynamicProperty {
    var timerRepository = CarouselTimerRepository()
}

// MARK: - ViewModel
final class CarouselWrapperViewModel: ObservableObject {
    let dependency: CarouselWrapperDependency
    let store: Store
    let input: Input
    let output: Output
    @ObservedObject var binding: Binding
    
    init(
        dependency: CarouselWrapperDependency = .init(),
        input: Input = .init(),
        output: Output = .init(), 
        binding: Binding = .init(),
        store: Store = .init()
    ) {
        self.dependency = dependency
        self.input = input
        self.output = output
        self.binding = binding
        self.store = store
        
        bind(dependency: dependency,
             input: input,
             output: output,
             binding: binding,
             store: store)
    }
}

extension CarouselWrapperViewModel {
    
    final class Input {
        let didAppear = PassthroughSubject<(), Never>()
        let didDisappear = PassthroughSubject<(), Never>()
        let didChangeOffset = PassthroughSubject<CGPoint, Never>()
    }
    
    final class Output: ObservableObject {
        @Published var models: [CarouselItemModel] = CarouselItemModel.stub
    }
    
    final class Binding: ObservableObject {
        @Published var scrollIndex: Int = 0
        @Published var scrollTimerEnabled: Bool = false
    }
    
    final class Store {
        var cancellables = Set<AnyCancellable>()
        var offset: CGPoint = .zero
        var index: Int { Int(floor(offset.x / (320 + 8))) } // width + spacing
    }
}

extension CarouselWrapperViewModel {
    
    func bind(
        dependency: CarouselWrapperDependency,
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
        
        input.didAppear
            .filter { binding.scrollTimerEnabled }
            .sink { 
                dependency.timerRepository.set() 
            }
            .store(in: &store.cancellables)
        
        input.didDisappear
            .filter { binding.scrollTimerEnabled }
            .sink { 
                binding.scrollTimerEnabled = false
                dependency.timerRepository.cancel() 
            }
            .store(in: &store.cancellables)
        
        input
            .didChangeOffset
            .assign(to: \.offset, on: store)
            .store(in: &store.cancellables)
        
        binding.$scrollTimerEnabled
            .filter { $0 }
            .sink { _ in dependency.timerRepository.set() }
            .store(in: &store.cancellables)
        
        dependency.timerRepository.timer
            .filter { binding.scrollTimerEnabled }
            .filter { !output.models.isEmpty }
            .map {
                guard binding.scrollIndex < output.models.count-1 else { return 0 }
                return store.index + 1
            }
            .assign(to: \.scrollIndex, on: binding)
            .store(in: &store.cancellables)
    }
}
