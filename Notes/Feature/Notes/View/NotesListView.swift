import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel: NotesListViewModel
    
    init() {
        let service = NotesServiceImplementation(apiClient: APIClient())
        _viewModel = StateObject(wrappedValue: NotesListViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoadingData {
                    Spacer()
                    ProgressView()
                }
                List {
                    ForEach(viewModel.visibleNotes) { note in
                        NoteCardView(note: note)
                            .onAppear {
                                if note == viewModel.visibleNotes.last {
                                    Task {
                                        await viewModel.loadNextPage()
                                    }
                                }
                            }
                        
                        if viewModel.isLoadingNextPage {
                            ProgressView()
                        }
                    }
                    .onDelete { _ in
                        viewModel.deleteNote()
                    }
                }
                .refreshable {
                    await viewModel.fetchNotesFromAPI()
                }
                .searchable(text: $viewModel.searchText, prompt: "search by title/description")
            }
            .navigationTitle("Notes")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Add Note") {
                        AddNoteView()
                    }

                }
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
