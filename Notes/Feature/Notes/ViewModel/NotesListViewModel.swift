import Foundation

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published var allNotes: [NoteResponse] = []
    @Published var visibleNotes: [NoteResponse] = []
    @Published var searchText: String = ""
    
    @Published var isLoadingData = false
    @Published var isLoadingNextPage = false
    @Published var errorMessage: String = ""
    @Published var showAlert = false
    private var dataFetched = false
    
    
    private var currentPage = 0
    private let pageSize = 10

    let service: NotesService
    
    init(service: NotesService) {
        self.service = service
        Task {
            await loadNextPage()
        }
    }
    
    func loadNextPage() async {
        print("fetch next page called")
        isLoadingNextPage = true
        defer {
            isLoadingNextPage = false
        }
        if !dataFetched  {
            await fetchNotesFromAPI()
        }
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allNotes.count)

        guard startIndex < allNotes.count else { return } // No more items to load

        let newNotes = Array(allNotes[startIndex..<endIndex])
        visibleNotes.append(contentsOf: newNotes)
        currentPage += 1
        print("\(currentPage)")
    }
    
    func fetchNotesFromAPI() async {
        isLoadingData = true
        defer {
            isLoadingData = false
        }
        do {
            let data = try await service.fetchPosts()
            self.allNotes = data
            dataFetched = true
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }

    func deleteNote() {
        
    }
}
