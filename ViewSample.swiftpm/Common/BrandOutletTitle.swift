import SwiftUI

struct SectionTitle: View {
    let title: String
    let didTapButton: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            if let action = didTapButton {
                ChevronRightButton(title: "Button", action: action)
            }
        }
        .padding(.init(top: 16, leading: 24, bottom: 16, trailing: 24))
        .frame(maxWidth: 700)
    }
    
    init(title: String, didTapButton: (() -> Void)? = nil) {
        self.title = title
        self.didTapButton = didTapButton
    }
}
