import SwiftUI

struct AddNoteView: View {
    @StateObject private var viewModel = AddNoteViewModel()
    let listViewModel: NotesListViewModel
    
    init(viewModel: NotesListViewModel) {
        self.listViewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                } header: {
                    Text("Title")
                }

                Section {
                    TextEditor(text: $viewModel.description)
                } header: {
                    Text("Description")
                }
            }
            
            HStack {
                Spacer()
                Button {
                    viewModel.resetNote()
                } label: {
                    Text("Reset")
                }
                Spacer()
                
                Button {
                    viewModel.saveNote()
                    listViewModel.loadFirstPage()
                } label: {
                    Text("Save")
                }
                Spacer()
            }
            .padding()
           
        }
        .navigationTitle("Add a new Note")
        .navigationBarTitleDisplayMode(.inline)
        .alert(viewModel.message ?? StringConstants.alertTitle.rawValue, isPresented: $viewModel.showAlert) {
                   Button("OK", role: .cancel, action: {}) }
    }
}

#Preview {
    AddNoteView(viewModel: NotesListViewModel(service: NotesServiceImplementation()))
}
