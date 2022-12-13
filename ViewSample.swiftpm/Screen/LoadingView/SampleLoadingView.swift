import SwiftUI


struct SampleLoadingView: View {
    
    @ObservedObject var configuration: LoadingConfiguration = {
        var config = LoadingConfiguration()
        config.title = "Loading..."
        return config
    }()
    
    var body: some View {
        Text("parent\nview")
            .frame(width: 300, height: 400, alignment: .center)
            .setLoading(configuration)
            .onAppear {
                configuration.enabled = true
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.configuration.showsProgress = false
                    self.configuration.title = "Finished"
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    self.configuration.enabled = false
                }
            }
            .onDisappear {
                configuration.enabled = true
                configuration.showsProgress = true
            }
    }
}
