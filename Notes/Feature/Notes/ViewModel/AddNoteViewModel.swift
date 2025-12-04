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
        
        
    }
    
    func resetNote() {
        title = ""
        description = ""
    }
}
