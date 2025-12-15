import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    let viewContext = CorePersistence.sharedContainer.viewContext
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, viewContext)
            
        }
    }
}
