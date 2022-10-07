import SwiftUI

// MARK: - ViewModel
final class WrapperViewModel: ObservableObject {
    @Published var tabType: TabType = .banana
}

// MARK: - Parent
struct TabWrapperView: View {
    @ObservedObject var viewModel: WrapperViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TabView(
                    tabType: viewModel.tabType,
                    didTapTab: { viewModel.tabType = $0 }
                )
                switch viewModel.tabType {
                case .apple: AnyView(AppleView())
                case .banana: AnyView(BananaView())
                case .avocado: AnyView(AvocadeView())
                }
            }
            .padding(32)
        }
    }
}

// MARK: - Children
struct AppleView: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 500)
            .foregroundColor(.red)
    }
}
struct BananaView: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 500)
            .foregroundColor(.yellow)
    }
}
struct AvocadeView: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 500)
            .foregroundColor(.green)
    }
}
