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
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.visibleNotes) { note in
                            NoteCardView(note: note)
                                .onAppear {
                                    if note == viewModel.visibleNotes.last {
                                        Task { await viewModel.loadNextPage() }
                                    }
                                }
                        }
                        .onDelete(perform: deleteNote)
                        
                        if viewModel.isLoadingNextPage {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchNotesFromAPI()
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Search by title/description")
                    .onChange(of: viewModel.searchText) { oldValue, newValue in
                        viewModel.performLocalSearch()
                    }
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Add Note") {
                        AddNoteView()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchNotesFromStore()
        }
    }
}

extension NotesListView {
    private func deleteNote(at offsets: IndexSet) {
        for index in offsets {
            let item = viewModel.visibleNotes[index]
            viewModel.deleteNote(id: Int(item.noteId))
        }
        
        viewModel.visibleNotes.remove(atOffsets: offsets)
    }
}

#Preview {
    NotesListView()
}
