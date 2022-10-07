import SwiftUI

// MARK: - View Type
enum SampleType: Int, CaseIterable {
    case tab, rectangle
    
    var title: String {
        switch self {
        case .tab: return "Tab Sample"
        case .rectangle: return "Variable Rectangle"
        }
    }
    
    var destination: some View {
        switch self {
        case .tab: return TabWrapperView()
        case .rectangle: return WhiteLayer{ RectangleWrapperView() }
        }
    }
}

