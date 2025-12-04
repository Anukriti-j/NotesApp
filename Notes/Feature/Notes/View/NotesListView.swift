import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel: NotesListViewModel
    
    init() {
        let service = NotesServiceImplementation(apiClient: APIClient())
        _viewModel = StateObject(wrappedValue: NotesListViewModel(service: service))
    }
    
    var body: some View {
        
        List {
            ForEach(viewModel.notes) { note in
                Text(note.title)
            }
        }
        
        .onAppear {
            Task {
                await viewModel.fetchNotesFromAPI()
            }
        }
    }
}

#Preview {
    NotesListView()
}
