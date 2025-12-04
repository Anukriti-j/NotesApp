import SwiftUI

struct RootView: View {
    @AppStorage("userId") var userId: String?
    
    var body: some View {
        
        if userId != nil {
            MainTabView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
}
