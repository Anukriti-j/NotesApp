import SwiftUI

struct NotesListView: View {
    @StateObject private var viewModel: NotesListViewModel
    
    init() {
        let service = NotesServiceImplementation()
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
                        ForEach(Array(viewModel.visibleNotes.enumerated()), id: \.element.id) { index, note in
                            NoteRowView(
                                note: note,
                                isLast: index == viewModel.visibleNotes.count - 1
                            ) {
                                await viewModel.loadNextPage()
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
                        AddNoteView(viewModel: viewModel)
                    }
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showAlert) {
                    Button("ok", role: .cancel) { }
                    
                } message: {
                    Text(viewModel.errorMessage)
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
            viewModel.deleteNote(id: Int(item.id))
        }
        
        viewModel.visibleNotes.remove(atOffsets: offsets)
    }
}

#Preview {
    NotesListView()
}
