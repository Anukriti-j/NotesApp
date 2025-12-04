import SwiftUI
import CoreData

struct MainTabView: View {
    
    var body: some View {
        TabView {
            NotesListView()
                .tabItem {
                    Label("Notes", systemImage: "house.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
}
