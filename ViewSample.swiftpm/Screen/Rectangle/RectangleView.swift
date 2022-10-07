import SwiftUI

// MARK: - View
struct RectangleView: View {
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
            Image("343x120")
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing, .bottom], 16) // ipad = 24
        }
    }
}
