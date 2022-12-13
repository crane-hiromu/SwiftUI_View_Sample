import SwiftUI

// MARK: - ViewModifier
struct LoadingModifier: ViewModifier {
    @ObservedObject var configuration: LoadingConfiguration
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Group {
                    LoadingFilterView()
                    LoadingView()
                }
                .opacity(configuration.enabled ? 1.0 : 0.0)
                .animation(configuration.animation, value: configuration.enabled)
                .environmentObject(configuration)
            }
            .padding(.all, 16.0)
    }
}

// MARK: - Extension
extension View {
    func setLoading(_ configuration: LoadingConfiguration) -> some View {
        modifier(LoadingModifier(configuration: configuration))
    }
}
