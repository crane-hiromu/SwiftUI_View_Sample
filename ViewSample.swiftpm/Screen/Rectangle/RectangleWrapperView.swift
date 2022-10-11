import SwiftUI

// MARK: - Parent
struct RectangleWrapperView: View {
    let models: [RectangleModel] = RectangleModel.stub
    
    var body: some View {
        if !models.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                SectionTitle(title: "Section Title") {
                    print("tap section title button")
                }
                
                ForEach(models, id:\.bannerId) { model in
                    RectangleView(
                        didTap: { 
                            print("tap id: \(model.bannerId)") 
                        }
                    )
                }
                Spacer()
            }
        }
    }
}

// MARK: - Model
final class RectangleModel {
    let bannerId: Int = UUID().hashValue
    
    static var stub: [RectangleModel] = [
        .init(), .init(), .init()
    ]
}
