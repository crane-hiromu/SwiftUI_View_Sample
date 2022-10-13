import Combine
import Foundation

// MARK: - Protocol
protocol CarouselTimerRepositoryProtocol {
    var timer: AnyPublisher<(), Never> { get }
    
    func set()
    func cancel()
}

// MARK: - Repository
final class CarouselTimerRepository {
    var timer: AnyPublisher<(), Never> { _timer.eraseToAnyPublisher() }
    private var _timer = PassthroughSubject<(), Never>()
    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - CarouselTimerRepositoryProtocol
extension CarouselTimerRepository: CarouselTimerRepositoryProtocol {
    
    func set() {
        Timer
            .publish(every: 4.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?._timer.send(())
            }
            .store(in: &cancellables)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables = []
    }
}
