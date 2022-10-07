import SwiftUI

// MARK: - View
struct TabView: View {
    @Namespace private var namespace
    let tabType: TabType
    let didTapTab: (TabType) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases, id: \.rawValue) { type in
                TabItem(
                    type: type,
                    namespace: namespace, 
                    isSelected: tabType == type,
                    didTap: { didTapTab(type) }
                )
            }
        }.background { tabBackground }
    }

    private var tabBackground: some View {
        Capsule()
            .fill(.white)
    }
}

struct TabItem: View {
    var type: TabType
    var namespace: Namespace.ID
    var isSelected: Bool
    var didTap: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut, didTap)
        }, label: { 
            Text(type.rawValue)
                .font(Font.system(size: 14, weight: .bold, design: .default))
                .padding(.vertical, 8)
                .frame(width: 114)
                .foregroundColor(isSelected ? .white : .tabGray)
                .background { TabItemBackground(isSelected: isSelected, namespace: namespace) }
        })
    }
}

struct TabItemBackground: View {
    var isSelected: Bool
    var namespace: Namespace.ID
    
    var body: some View {
        if isSelected {
            Capsule()
                .fill(Color.tabGray)
                .matchedGeometryEffect(id: "Button", in: namespace)
        }
    }
}

// sample color
private extension Color {
    static let tabGray = Color(red: 0.259, green: 0.259, blue: 0.259)
}
