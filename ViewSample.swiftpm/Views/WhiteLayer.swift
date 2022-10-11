import SwiftUI

struct WhiteLayer<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 16) { content }
            .background(.white)
            .frame(maxWidth: 658)
    }
}
