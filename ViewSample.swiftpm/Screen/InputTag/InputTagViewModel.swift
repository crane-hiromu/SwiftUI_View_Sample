import SwiftUI
import Combine

// MARK: - ViewModel
final class InputTagViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let input: Input
    let output: Output
    @ObservedObject var binding: Binding
    
    init(
        input: Input = .init(),
        output: Output = .init(configuration: .init()),
        binding: Binding
    ) {
        self.input = input
        self.output = output
        self.binding = binding
        
        bind(input: input, 
             output: output, 
             binding: binding)
    }
}

// MARK: - Property
extension InputTagViewModel {
    
    final class Input {
        let didTapTag = PassthroughSubject<String, Never>()
        let didTapEnd = PassthroughSubject<(), Never>()
    }
    
    final class Output: ObservableObject {
        @ObservedObject var configuration: InputTagViewConfiguration
        let didTapTag = PassthroughSubject<String, Never>()
        let didTapEnd = PassthroughSubject<(), Never>()
        
        init(configuration: InputTagViewConfiguration) {
            self.configuration = configuration
        }
    }
    
    final class Binding: ObservableObject {
        @Published var tags: [String]
        
        init(tags: [String]) {
            self.tags = tags
        }
    }
}

// MARK: - Private
private extension InputTagViewModel {
    
    func bind(
        input: Input,
        output: Output,
        binding: Binding
    ) {
        input.didTapTag
            .compactMap { binding.tags.firstIndex(of: $0) }
            .sink { index in
                withAnimation {
                    _ = binding.tags.remove(at: index)
                }
            }
            .store(in: &cancellables)
        
        input.didTapTag
            .removeDuplicates()
            .sink { output.didTapTag.send($0) }
            .store(in: &cancellables)
        
        input.didTapEnd
            .sink { output.didTapEnd.send(()) }
            .store(in: &cancellables)
        
        binding.objectWillChange
            .sink { [weak self] in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }
}
