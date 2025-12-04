import Foundation
import CoreData

protocol StorageService {
    func setUpGuestUser()
    func setUpUserSession(userId: String)
    func clearSession()
}

final class StorageManager: StorageService {
    static let manager = StorageManager()
    private init() {}
    let context = CorePersistence().container.viewContext
    
    let users = [
        User(userId: UUID().uuidString, email: "anukriti.jain@gmail.com", password: "A@12345"),
        User(userId: UUID().uuidString, email: "chetan.girase@gmail.com", password: "C@12345")
    ]
    
    func setUpGuestUser() {
        for userData in users {
            let user = UserAuth(context: context)
            user.userId = userData.userId
            user.email = userData.email
            user.password = userData.password
        }
    }
    
    func setUpUserSession(userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func authenticateUser(email: String, password: String) throws {
        let request = UserAuth.fetchRequest()
         request.predicate = NSPredicate(format: "email == %@ AND password == %@", email,password)
        
        do {
            let user = try context.fetch(request)
            if user == [] {
                throw DatabaseError.userNotFound
            }
            if let firstUser = user.first {

                if let userId = firstUser.userId {
                    setUpUserSession(userId: userId)
                }
            }
        } catch {
            throw DatabaseError.userNotFound
        }
    }
   
}
