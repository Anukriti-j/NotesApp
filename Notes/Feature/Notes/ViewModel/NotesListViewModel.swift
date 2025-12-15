import Foundation

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published var allNotesFromAPI: [NoteResponse] = []
    @Published var notesFromCore: [Note] = []
    @Published var visibleNotes: [Note] = []
    @Published var searchText: String = ""

    @Published var isLoadingData = false
    @Published var isLoadingNextPage = false
    @Published var errorMessage: String = ""
    @Published var showAlert = false

    private var currentPage = 0
    private let pageSize = 10
    private var initialLoadDone = false

    let service: NotesService

    init(service: NotesService) {
        self.service = service
    }

    func loadNextPage() async {
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }

        if !initialLoadDone {
            await fetchNotesFromStore()
            initialLoadDone = true
        }

        let startIndex = currentPage * pageSize
        guard startIndex < notesFromCore.count else { return } // No more pages

        let endIndex = min(startIndex + pageSize, notesFromCore.count)
        let nextBatch = Array(notesFromCore[startIndex..<endIndex])
        visibleNotes.append(contentsOf: nextBatch)

        currentPage += 1
    }

    func fetchNotesFromAPI() async {
        isLoadingData = true
        defer { isLoadingData = false }

        do {
            let data = try await service.fetchPosts()
            print(data)
            self.allNotesFromAPI = data
            
            try StorageManager.manager.saveNotes(notes: data)

            notesFromCore = try StorageManager.manager.fetchNotes()

            loadFirstPage()

        } catch {
            print("API Fetch Error: \(error)")
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }

    func fetchNotesFromStore() async {
        do {
            notesFromCore = try StorageManager.manager.fetchNotes()

            if notesFromCore.isEmpty {
                guard !isLoadingData else { return }
                await fetchNotesFromAPI()
                return
            }
            loadFirstPage()

        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }

    func deleteNote(id: Int) {
        do {
            try StorageManager.manager.deleteNote(id: id)
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    func performLocalSearch() {
        let query = searchText
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if query.isEmpty {
            visibleNotes = notesFromCore   
            return
        }

        visibleNotes = notesFromCore.filter { note in
            (note.title?.localizedCaseInsensitiveContains(query) ?? false) ||
            (note.body?.localizedCaseInsensitiveContains(query) ?? false)
        }
    }

    func loadFirstPage() {
        visibleNotes.removeAll()
        currentPage = 0

        let endIndex = min(pageSize, notesFromCore.count)
        if endIndex > 0 {
            visibleNotes = Array(notesFromCore[0..<endIndex])
            currentPage = 1
        }
    }
}
