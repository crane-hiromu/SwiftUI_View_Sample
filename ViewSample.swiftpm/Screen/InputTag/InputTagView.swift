import SwiftUI

// MARK: - View
struct InputTagView: View {
    @ObservedObject var viewModel: InputTagViewModel
    
    var body: some View {
        HStack(spacing: viewModel.output.configuration.horizontalPadding) {
            ZStack {
                InputTagCollection(
                    tags: viewModel.binding.tags,
                    didTapTag: { viewModel.input.didTapTag.send($0) }
                )
                InputTagCollectionBlur()
            }

            InputEndButton(
                didTap: { }
            )
        }
        .background(Color.white)
        .environmentObject(viewModel.output.configuration)
    }
}

// MARK: - Collection
private struct InputTagCollection: View {
    @EnvironmentObject var configuration: InputTagViewConfiguration
    let tags: [String]
    let didTapTag: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: configuration.showsIndicators) {
            LazyHStack(spacing: configuration.tagSpacing) {
                ForEach(tags, id: \.self) { tag in
                    InputTagItem(
                        tag: tag, 
                        didTap: { didTapTag(tag) }
                    )
                }
            }
            .padding(.leading, configuration.horizontalPadding)
        }
        .frame(height: configuration.tagCollectionHeight)
    }
}

// MARK: - Blur
private struct InputTagCollectionBlur: View {
    
    var body: some View {
        LinearGradient(
            colors: [.white.opacity(0.0), .white],
            startPoint: .center,
            endPoint: .trailing
        )
        .allowsHitTesting(false)
    }
}

// MARK: - Item
private struct InputTagItem: View {
    @EnvironmentObject var configuration: InputTagViewConfiguration
    let tag: String
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
            Text(tag)
                .foregroundColor(configuration.tagColor)
                .padding(.vertical, configuration.tagVerticalPadding)
                .padding(.horizontal, configuration.tagHorizontalPadding - configuration.tagLineWidth)
                .overlay(borderOverlay)
        }
        .padding(.horizontal, configuration.tagLineWidth)
    }
    
    private var borderOverlay: some View {
        RoundedRectangle(cornerRadius: configuration.tagCornerRadius)
            .stroke(configuration.tagColor, lineWidth: configuration.tagLineWidth)
    }
}

// MARK: - Button
private struct InputEndButton: View {
    @EnvironmentObject var configuration: InputTagViewConfiguration
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) { 
            Text(configuration.buttonTitle)
                .font(.system(size: 17).weight(.bold))
        }
        .padding(.trailing, configuration.horizontalPadding)
    }
}
