import Foundation

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published var notes: [PostResponse] = []
    @Published var errorMessage: String = ""
    @Published var showAlert = false
    
    let service: NotesService
    
    init(service: NotesService) {
        self.service = service
    }
    
    func fetchNotesFromAPI() async {
        do {
            let data = try await service.fetchPosts()
            self.notes = data
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
}
