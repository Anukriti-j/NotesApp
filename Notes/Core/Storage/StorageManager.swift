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
    
    let context = CorePersistence.sharedContainer.viewContext
    
    let users = [
        User(userId: UUID().uuidString, email: "anukriti.jain@gmail.com", password: "A@12345"),
        User(userId: UUID().uuidString, email: "chetan.girase@gmail.com", password: "C@12345")
    ]
    
    func setUpGuestUser() {
        for userData in users {
            let user = Auth(context: context)
            user.userId = userData.userId
            user.email = userData.email
            user.password = userData.password
        }
        try? context.save()
    }
    
    func setUpUserSession(userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func authenticateUser(email: String, password: String) throws {
        let request = Auth.fetchRequest()
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

extension StorageManager {
    
    func saveNotes(notes: [NoteResponse]) throws {
        
        for note in notes {
            
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %lld", note.id)
            
            if let existing = try self.context.fetch(fetchRequest).first {
                existing.id = Int64(note.id)
                existing.title = note.title
                existing.body = note.body
                existing.createdAt = Date()
            } else {
                let newNote = Note(context: context)
                newNote.id = Int64(note.id)
                newNote.title = note.title
                newNote.body = note.body
                newNote.createdAt = Date()
            }
        }

        if context.hasChanges {
            try context.save()
        }
    }
    
    @MainActor
    func deleteNote(id: Int) throws {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", id)
        do {
            if let noteToDelete = try context.fetch(request).first {
                context.delete(noteToDelete)
            }
            try context.save()
        }
        catch {
            throw DatabaseError.deletionError
        }
    }
    
    func fetchNotes() throws -> [Note] {
        let request = Note.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw DatabaseError.fetchError
        }
    }
    
    func addOrUpdateNote(note: NoteResponse) throws {
        let newNote = Note(context: context)
        newNote.id = Int64(note.id)
        newNote.title = note.title
        newNote.body = note.body
        newNote.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            throw DatabaseError.saveError
        }
    }
    
}
