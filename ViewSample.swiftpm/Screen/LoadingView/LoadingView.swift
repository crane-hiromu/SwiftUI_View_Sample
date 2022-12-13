import SwiftUI

// MARK: - View
struct LoadingView: View {
    @EnvironmentObject var configuration: LoadingConfiguration
    
    var body: some View {
        VStack(spacing: 0) {
            if configuration.showsProgress {
                progressView
            } else {
                checkmarkImage
            }
            if !configuration.title.isNilOrEmpty {
                titleText
            }
        }
        .padding(.all, configuration.padding)
        .background(configuration.backgroundColor)
        .cornerRadius(configuration.cornerRadius)
    }
}

// MARK: - Private
private extension LoadingView {
    
    var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(configuration.progressColor)
            .padding(.bottom, configuration.progressBottomPadding)
    }
    
    var checkmarkImage: some View {
        Image(systemName: "checkmark")
            .resizable()
            .aspectRatio(contentMode: configuration.progressImageMode)
            .frame(
                width: configuration.progressImageSize.width, 
                height: configuration.progressImageSize.height
            )
            .foregroundColor(configuration.progressColor)
            .padding(.bottom, configuration.progressBottomPadding)
    }
    
    var titleText: some View {
        Text(configuration.title ?? "")
            .font(configuration.titleFont)
    }
}
