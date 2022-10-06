import SwiftUI

final class WrapperViewModel: ObservableObject {
    @Published var tabType: TabType = .banana
}

struct WrapperView: View {
    @ObservedObject var viewModel: WrapperViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TabView(
                    tabType: viewModel.tabType,
                    didTapTab: { viewModel.tabType = $0 }
                )
                
                Rectangle()
                    .frame(height: 500)
                    .foregroundColor({
                        switch viewModel.tabType {
                        case .apple: return Color.red
                        case .banana: return Color.yellow
                        case .avocado: return Color.green
                        }
                    }())
            }
            .padding(32)
        }
    }
}
