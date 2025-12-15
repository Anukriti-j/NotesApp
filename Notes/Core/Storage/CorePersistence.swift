import Foundation
import CoreData

struct CorePersistence {
    
    static let sharedContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private init() {}
}
