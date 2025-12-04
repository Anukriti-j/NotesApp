import Foundation

final class AddNoteViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    
    @Published var message: String?
    @Published var showAlert = false
    
    func isFormValid() -> Bool {
        guard !title.isEmpty && !description.isEmpty else {
            message = StringConstants.invalidForm.rawValue
            showAlert = true
            return false
        }
        return true
    }
    
    func saveNote() {
        guard isFormValid() else { return }
        let note = NoteResponse(userID: nil, id: Int(UUID().hashValue), title: title, body: description)
        do {
            try StorageManager.manager.addOrUpdateNote(note: note)
            message = StringConstants.success.rawValue
            showAlert = true
            resetNote()
        } catch {
            message = error.localizedDescription
            showAlert = true
        }
        
    }
    
    func resetNote() {
        title = ""
        description = ""
    }
}
