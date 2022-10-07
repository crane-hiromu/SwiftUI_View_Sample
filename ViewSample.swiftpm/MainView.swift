import SwiftUI

// MARK: - View
struct MainView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(SampleType.allCases, id: \.rawValue) {
                        MainRow(type: $0)
                    }
                }
                .background(.white)
            }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Row
struct MainRow: View {
    let type: SampleType
    
    var body: some View {
        NavigationLink(destination: {
            type.destination
                .navigationBarTitle(type.title, displayMode: .inline)
        }, label: {
            Text(type.title)
                .foregroundColor(.black)
                .padding()
        })
    }
}
