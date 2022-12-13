import SwiftUI

// MARK: - View
struct LoadingFilterView: View {
    @EnvironmentObject var configuration: LoadingConfiguration
    
    var body: some View {
        Rectangle()
            .foregroundColor(
                configuration.filterColor.opacity(configuration.filterOpacity)
            )
    }
}
