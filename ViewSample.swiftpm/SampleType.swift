import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        }
    }
    
    var destination: some View {
        switch self {
        case .tab: return TabWrapperView()
        }
    }
}
